defmodule Takso.Services.Geolocation do
    # use ExUnit.Case
    

    def duration_hour_min(origin, destination) do
        %{"routes" => [%{"legs" => [%{
            "duration" => %{"text" => trip_duration_hour_min, "value" => _trip_duration_value}
        }]}]} = trip_duration(origin, destination)
        trip_duration_hour_min
    end

    # import Mock
    def trip_duration(origin, destination) do
        origin = String.replace(origin, ",", "") |> String.replace(" ", "+")
        destination = String.replace(destination, ",", "") |> String.replace(" ", "+")
        mY_API_KEY = "AIzaSyAvvr0iB4tiDAgPj-kGXhjKoAiMKobB1H4"
        url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{mY_API_KEY}"
        response =
            HTTPoison.get!(url)
        Poison.decode!(response.body)
        
        # %{body: body} = HTTPoison.get! url
        # Regex.named_captures ~r/duration\D+(?<duration_text>\d+ mins)\D+(?<duration_value>\d+)/, body
        # body
        # |> Floki.find("sitemap loc") 
        # |> Enum.map(fn(element) -> Floki.text(element) end)
        # %{duration_text: duration_text, duration_value: duration_value |> Integer.parse |> elem(0)}
    end

end