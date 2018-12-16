# x = [
#     %Takso.Booking{
#       __meta__: #Ecto.Schema.Metadata<:loaded, "bookings">,
#       dropoff_address: "qsd",
#       id: 1,
#       inserted_at: ~N[2018-12-15 03:23:41.072477],
#       pickup_address: "sd",
#       status: "open",
#       updated_at: ~N[2018-12-15 03:23:41.076924],
#       user: #Ecto.Association.NotLoaded<association :user is not loaded>,
#       user_id: 3
#     },  %Takso.Booking{
#       __meta__: #Ecto.Schema.Metadata<:loaded, "bookings">,
#       dropoff_address: "qsd",
#       id: 14,
#       inserted_at: ~N[2018-12-15 22:11:48.937571],
#       pickup_address: "qsdqs",
#       status: "open",
#       updated_at: ~N[2018-12-15 22:11:48.937606],
#       user: #Ecto.Association.NotLoaded<association :user is not loaded>,
#       user_id: 2
#     }
#   ]

defmodule TestModule do
    def test() do
        x = [%Takso.Booking{}]
    end 
end