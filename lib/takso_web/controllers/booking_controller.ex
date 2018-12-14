defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias Takso.{Booking, Taxi, Repo}

  def new(conn, _params) do
    render conn, "new.html", changeset: Booking.changeset(%Booking{}, %{})
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, _params) do
    query = from t in Taxi, 
            where: t.status == "available", 
            select: t
            
    available_taxis = Repo.all(query)

    if length available_taxis > 0 do
      conn
      |> put_flash(:info, "Your taxi will arrive in 5 minutes")
      |> redirect(to: booking_path(conn, :index))
    else
      conn
      |> put_flash(:error, "No available taxi, please try again later")
      |> redirect(to: booking_path(conn, :index))
    end
    conn
    |> put_flash(:info, "Your taxi will arrive in 5 minutes")
    |> redirect(to: booking_path(conn, :index))
  end
end