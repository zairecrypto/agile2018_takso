defmodule Takso.Geolocation do
    # use ExUnit.Case
    
    # import Mock
    def trip_duration(origin, destination) do
        origin = String.replace(origin, ",", "") |> String.replace(" ", "+")
        destination = String.replace(destination, ",", "") |> String.replace(" ", "+")
        mY_API_KEY = "AIzaSyAvvr0iB4tiDAgPj-kGXhjKoAiMKobB1H4"
        url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&key=#{mY_API_KEY}"
        %{body: body} = HTTPoison.get! url
        %{"duration_text" => duration_text, "duration_value" => duration_value} = Regex.named_captures ~r/duration\D+(?<duration_text>\d+ mins)\D+(?<duration_value>\d+)/, body
        %{duration_text: duration_text, duration_value: duration_value |> Integer.parse |> elem(0)}
    end
end