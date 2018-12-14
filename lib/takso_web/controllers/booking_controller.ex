defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller

  alias Takso.Booking

  def new(conn, _params) do
    render conn, "new.html", changeset: Booking.changeset(%Booking{}, %{})
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, _params) do
    conn
    |> put_flash(:info, "Your taxi will arrive in 5 minutes")
    |> redirect(to: booking_path(conn, :index))
  end
end