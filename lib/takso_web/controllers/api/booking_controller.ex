defmodule TaksoWeb.Api.BookingController do
    use TaksoWeb, :controller
    import Ecto.Query, only: [from: 2]
    import Ecto.Changeset
    # import TaksoWeb.GeolocationJob
  
    # alias Takso.{Repo, Sales, Accounts.User, }
    alias Takso.{Booking, Taxi, Repo, Accounts.User, Sales.Allocation, Services.Geolocation }

    def create(conn, %{"dropoff_address" => dropoff_address, "pickup_address" => pickup_address}) do
        
        %{"routes" => [%{"legs" => [%{
            "distance" => %{"text" => trip_distance_in_KM, "value" => trip_distance_value},
            "duration" => %{"text" => trip_duration_hour_min, "value" => trip_duration_value},
            "end_address" => trip_end_address,
            "start_address" => trip_start_address
        }]}]} = Geolocation.trip_duration(pickup_address, dropoff_address)

            # {
            #     trip_distance_in_KM, 
            #     trip_distance_value, 
            #     trip_duration_hour_min, 
            #     trip_duration_value, 
            #     trip_end_address, 
            #     trip_start_address
            # }
          
      available_taxis = Repo.all(from t in Taxi, where: t.status == "available", select: t)
      if length(available_taxis) > 0 do
        taxi = List.first(available_taxis)
        taxi_duration_hour_min = Geolocation.duration_hour_min(pickup_address, taxi.location)

        # Message to user
        IO.puts "taxi will arrive in : #{taxi_duration_hour_min}"
        IO.puts "From: #{trip_start_address} to #{trip_end_address} for #{trip_duration_hour_min}"


        put_status(conn, 201)
        |> json(
            %{
                msg: "Your taxi will arrive in #{taxi_duration_hour_min}", 
                taxi_location: taxi.location
            })
      else
        put_status(conn, 409)
        |> json(%{msg: "Booking request cannot be served"})
      end
    end
  end
