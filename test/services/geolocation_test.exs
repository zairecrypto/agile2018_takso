defmodule Takso.GeolocationTest do
    use ExUnit.Case
    import Mock

    test "calls google maps api" do   
        # with_mock HTTPoison, [get: fn(_url) -> 
        #     %HTTPoison.Response{body:
        #     """
        #     {
        #         "destination_addresses" : [ "Lõunakeskus, 51014 Tartu, Estonia" ],
        #         "origin_addresses" : [ "Juhan Liivi 2, 50409 Tartu, Estonia" ],
        #         "rows" : [
        #            {
        #               "elements" : [
        #                  {
        #                     "distance" : {
        #                        "text" : "2.6 mi",
        #                        "value" : 4127
        #                     },
        #                     "duration" : {
        #                        "text" : "9 mins",
        #                        "value" : 534
        #                     },
        #                     "status" : "OK"
        #                  }
        #               ]
        #            }
        #         ],
        #         "status" : "OK"
        #      }
        #     """
        #     } end] do            
        #     duration = Takso.Geolocation.trip_duration("Liivi 2, Tartu, Estonia", "Lounakeskus, Tartu, Estonia")
        #     assert called HTTPoison.get!("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Liivi+2+Tartu+Estonia&destinations=Lounakeskus+Tartu+Estonia&key=AIzaSyAvvr0iB4tiDAgPj-kGXhjKoAiMKobB1H4")
        #     assert duration == 534
        end
    end
end