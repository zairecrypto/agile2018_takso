defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias Takso.{Booking, Taxi, Repo, Accounts.User, Sales.Allocation, Geolocation}

  def new(conn, _) do 
    changeset = Booking.changeset(%Booking{}, %{})
    render conn, "new.html", changeset: changeset, user: Integer.to_string conn.assigns.current_user.id
  end

  # Show is used to see all booking related logs
  def show(conn, _) do
    user_id = (Integer.to_string conn.assigns.current_user.id) && "1"
    case String.equivalent?(user_id,"show") do
      true -> 
        users = Repo.all(User)
        taxis = Repo.all(Taxi)
        render(conn, "show.html", users: users, taxis: taxis)
      false -> 
        query = from b in Booking, 
                where: b.user_id == ^user_id
        bookings = Repo.all(query)
        render conn, "index.html", bookings: bookings
    end
  end

  def index(conn, _params) do
    # query = from b in Booking, 
    #         where: b.user_id == ^conn.assigns.current_user.id
    bookings = Repo.all(Booking)
    render conn, "index.html", bookings: bookings
  end

  # show a summary of the number of booking requests accepted by each one of the taxis
  def summary(conn, _params) do

    query = from t in Taxi,
            join: a in Allocation, on: t.id == a.taxi_id,
            group_by: t.username,
            where: a.status == "accepted",
            select: {t.username, count(a.id)}
    tuples = Repo.all(query)
    IO.inspect tuples
    render conn, "summary.html", tuples: tuples
  end

  def create(conn, %{"booking" => booking_params}) do
    user_id = Integer.to_string conn.assigns.current_user.id
    user = Repo.get!(User, user_id)

    %{"dropoff_address" => do_address, "pickup_address" => pu_address} = booking_params
    if String.equivalent?(do_address, pu_address) 
      || String.equivalent?(do_address, "") 
      || String.equivalent?(pu_address, "") 
      do
        conn
        |> put_flash(:error, "Something went wrong! Please check your Pickup Address and your Droppoff Address")
        |> redirect(to: booking_path(conn, :new, %{user_id: user}))
      else
        

        booking_struct = Ecto.build_assoc(user, :bookings, Enum.map(booking_params, fn({key, value}) -> {String.to_atom(key), value} end))
        
        changeset = Booking.changeset(booking_struct)
                    |> Ecto.Changeset.put_change(:status, "open")
    
        booking = Repo.insert!(changeset)
    
        query = from t in Taxi, 
                where: t.status == "available", 
                select: t
              
        available_taxis = Repo.all(query)
        IO.inspect available_taxis
    
        if length(available_taxis) > 0 do
          taxi = List.first(available_taxis)
    
          Ecto.Multi.new
          |> Ecto.Multi.insert(:allocation, Allocation.changeset(%Allocation{}, %{status: "accepted"}) |> Ecto.Changeset.put_change(:booking_id, booking.id) |> Ecto.Changeset.put_change(:taxi_id, taxi.id))
          |> Ecto.Multi.update(:taxi, Taxi.changeset(taxi) |> Ecto.Changeset.put_change(:status, "busy"))
          |> Ecto.Multi.update(:booking, Booking.changeset(booking) |> Ecto.Changeset.put_change(:status, "allocated"))
          |> Repo.transaction
    
          

          conn
          |> put_flash(:info, "Your taxi will arrive in 5 minutes")
          |> redirect(to: booking_path(conn, :index))
        else
          Booking.changeset(booking) |> Ecto.Changeset.put_change(:status, "rejected")
          |> Repo.update
    
          conn
          |> put_flash(:error, "We apologize, we cannot serve your request in this moment")
          |> redirect(to: booking_path(conn, :new, %{user_id: user}))
        end
    end

  end
end