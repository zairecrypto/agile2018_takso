defmodule TaksoWeb.BookingControllerTest do
  use Takso.ConnCase
  use TaksoWeb.ConnCase
  use ExUnit.Case

  alias Takso.{Taxi,Repo}
  import Takso.Factory

  # test "POST /bookings Fails", %{conn: conn} do
  #   [%{username: "juhan85", location: "Kaubamaja", status: "busy"}]
  #   |> Enum.map(fn taxi_data -> Taxi.changeset(%Taxi{}, taxi_data) end)
  #   |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
    
  #   conn = post conn, "/bookings", %{booking: [pickup_address: "Liivi 2", dropoff_address: "Lõunakeskus"]}
  #   conn = get conn, redirected_to(conn)
  #   assert html_response(conn, 200) =~ ~r/Sorry, No taxi available/
  # end

  # test "POST /bookings Success", %{conn: conn} do
  #   [%{username: "juhan85", location: "Kaubamaja", status: "available"}]
  #   |> Enum.map(fn taxi_data -> Taxi.changeset(%Taxi{}, taxi_data) end)
  #   |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
    
  #   conn = post conn, "/bookings", %{booking: [pickup_address: "Liivi 2", dropoff_address: "Lõunakeskus"]}
  #   conn = get conn, redirected_to(conn)
  #   assert html_response(conn, 200) =~ ~r/Your taxi will arrive in \d+ minutes/
  # end

  test "something" do
    # insert_list(5, :users)
  end
end