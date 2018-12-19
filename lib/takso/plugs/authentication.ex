defmodule Takso.Authentication do
  import Plug.Conn

  def init(props), do: props[:repo]
  def call(conn, repo) do
      user_id = get_session(conn, :user_id)
      user = user_id && repo.get(Takso.Accounts.User, user_id)
      login(conn, user_id, user)
    end
  
    def login(conn, user_id, user) do
      assign(conn, :current_user, user)
      |> put_session(:user_id, user_id)
    end
  
    def check_credentials(conn, username, password, [repo: repo]) do
      # IO.puts "I'm here"
      user = repo.get_by(Takso.Accounts.User, username: username)
      case user == nil do
        true  -> {:error, :unauthorized, conn}
        false ->
          if String.equivalent?(user.password, password) do
            {:ok, login(conn, user.id, user) }
          else
            {:error, :unauthorized, conn}
          end
      end
    end

  def logout(conn) do
      configure_session(conn, drop: true)

  end
end