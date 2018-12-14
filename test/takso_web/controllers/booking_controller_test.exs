defmodule TaksoWeb.BookingControllerTest do
  use TaksoWeb.ConnCase

  alias Takso.{Taxi,Repo}

  test "POST /bookings Fails", %{conn: conn} do
    [%{username: "juhan85", location: "Kaubamaja", status: "busy"}]
    |> Enum.map(fn taxi_data -> Taxi.changeset(%Taxi{}, taxi_data) end)
    |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
    
    conn = post conn, "/bookings", %{booking: [pickup_address: "Liivi 2", dropoff_address: "Lõunakeskus"]}
    conn = get conn, redirected_to(conn)
    assert html_response(conn, 200) =~ ~r/Sorry, No taxi available/
  end

  test "POST /bookings Success", %{conn: conn} do
    [%{username: "juhan85", location: "Kaubamaja", status: "available"}]
    |> Enum.map(fn taxi_data -> Taxi.changeset(%Taxi{}, taxi_data) end)
    |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
    
    conn = post conn, "/bookings", %{booking: [pickup_address: "Liivi 2", dropoff_address: "Lõunakeskus"]}
    conn = get conn, redirected_to(conn)
    assert html_response(conn, 200) =~ ~r/Your taxi will arrive in \d+ minutes/
  end
end