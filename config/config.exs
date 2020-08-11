# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :find_my_personal,
  ecto_repos: [FindMyPersonal.Repo]

# Configures the endpoint
config :find_my_personal, FindMyPersonalWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m9e8cZT4+qEGz+CNIBRZxjOr9DXugZgkvXb0srFL6rmEVwuJIVEk70lKFh92irSt",
  render_errors: [view: FindMyPersonalWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FindMyPersonal.PubSub,
  live_view: [signing_salt: "yEJfOpAI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
