defmodule TaksoWeb.Router do
  use TaksoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Takso.Authentication, repo: Takso.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaksoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/bookings/summary", BookingController, :summary
    resources "/users", UserController
    resources "/bookings", BookingController
    # resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/sessions", SessionController
  end

  # Other scopes may use custom stacks.
  scope "/api", TaksoWeb do
    pipe_through :api
    post "/bookings", Api.BookingController, :create
  end
end
