# defmodule Takso.Factory do
#     use ExMachina.Ecto, repo: Takso.Repo

#     def user_factory do
#         %Takso.User{
#             name: Faker.Name.name, 
#             username: sequence(:username, &"username#{&1}"), 
#             email: sequence(:email, &"email-#{&1}@example.com"),
#             password: Faker.String.base64, 
#             role: sequence(:role, fn (;x) -> Enum.random ["customer", "taxi-driver"] end)
#         }
#     end
    
# end