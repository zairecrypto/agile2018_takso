# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :takso,
  ecto_repos: [Takso.Repo]

# Configures the endpoint
config :takso, TaksoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "35Xv7TQuQymf4FPgKn2rYMHRMRu8wULRTmgjNH4t4H2QwNIr5qFTm23RN/jqKGP0",
  render_errors: [view: TaksoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Takso.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :takso, gmaps_api_key: "AIzaSyAvvr0iB4tiDAgPj-kGXhjKoAiMKobB1H4"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
