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

config :find_my_personal, FindMyPersonal.Mail.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.mailtrap.io",
  hostname: "smtp.mailtrap.io",
  port: 2525,
  username: "d29d8a4def7277",
  password: "pa51413c97c4aec695word",
  tls: :if_available,
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"],
  ssl: false,
  retries: 1,
  no_mx_lookups: false,
  auth: :if_available

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
