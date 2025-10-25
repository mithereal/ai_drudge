# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ai_drudge,
  ecto_repos: [AiDrudge.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :ai_drudge, AiDrudgeWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: AiDrudgeWeb.ErrorHTML, json: AiDrudgeWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: AiDrudge.PubSub,
  live_view: [signing_salt: "pY4MunOs"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ai_drudge, AiDrudge.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  ai_drudge: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.1.7",
  ai_drudge: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :agent_obs,
  enabled: true,
  handlers: [AgentObs.Handlers.Phoenix]

config :req_llm,
  default_model: "anthropic:claude-3-5-sonnet"

config :kaffy,
       otp_app: :ai_drudge,
       ecto_repo: AiDrudge.Repo,
       router: AiDrudgeWeb.Router,
       admin_title: "AI Drudge Admin",
       admin_logo: "/svg/logo.svg",
       admin_logo_mini: "/svg/logo.svg",
       admin_footer: "AI Drudge 2025",
       resources: &AiDrudge.Kaffy.Config.create_resources/1,
       scheduled_tasks: [
       ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
