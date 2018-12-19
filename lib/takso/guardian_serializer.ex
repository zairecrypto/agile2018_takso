defmodule Takso.GuardianSerializer do
    @behavior GuardianSerializer

    def for_token(%Takso.Accounts.User{} = user), do: {:ok, "User:#{user.id}"}
    def for_token(_), do: {:error, "Unknown Resource"}
    
    def from_token("User:"<>user_id), do: {:ok, Takso.Repo.get(Takso.Accounts.User, user_id)}
    def from_token(_), do: {:error, "Unknown Resource"}
end