defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias Takso.{Booking, Taxi, Repo, Accounts.User}

  def new(conn, %{"user_id" => user_id}) do
    changeset = Booking.changeset(%Booking{}, %{})
    render conn, "new.html", changeset: changeset, user: user_id
  end

  
  def index(conn, params) do
    render conn, "index.html"
  end


  def create(conn, %{"booking" => booking_params, "user_id" => user_id}) do
    user = user = Repo.get!(User, user_id)

    booking_struct = Ecto.build_assoc(user, :bookings, Enum.map(booking_params, fn({key, value}) -> {String.to_atom(key), value} end))
    Repo.insert(booking_struct)

    query = from t in Taxi, 
            where: t.status == "available", 
            select: t

    available_taxis = Repo.all(query)
    if length(available_taxis) > 0 do
      conn
      |> put_flash(:info, "Your taxi will arrive in 5 minutes")
      |> redirect(to: booking_path(conn, :index))
    else
      conn
      |> put_flash(:error, "We apologize, we cannot serve your request in this moment")
      |> redirect(to: booking_path(conn, :index))
    end
  end
end