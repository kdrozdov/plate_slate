# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :plate_slate,
  ecto_repos: [PlateSlate.Repo]

# Configures the endpoint
config :plate_slate, PlateSlateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8AcUsBmGTwslIaS6cluwcfNvqsovehWmj/Xo8k78lkBxtmIrny4K4gKXQUT1r8V0",
  render_errors: [view: PlateSlateWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PlateSlate.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "+WF2Ka1r"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
