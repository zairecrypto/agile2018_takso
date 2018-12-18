alias Takso.{Booking, Taxi, Repo, Accounts.User, Sales.Allocation, Services.Geolocation }

[%{name: "Fred Flintstone", username: "fred", password: "parool"},
 %{name: "Barney Rubble", username: "barney", password: "parool"}]
|> Enum.map(fn user_data -> User.changeset(%User{}, user_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)



Repo.insert!(%Taxi{location: "Turu 2", status: "available", username: "flash"})
Repo.insert!(%Taxi{location: "Turu 4, Tartu, Estonia", status: "available", username: "flash"})
Repo.insert!(%Taxi{location: "Parnu Mnt 102c, Tallinn, Estonia", status: "available", username: "flash"})
