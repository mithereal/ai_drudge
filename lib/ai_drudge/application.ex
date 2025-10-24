defmodule AiDrudge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AiDrudgeWeb.Telemetry,
      AiDrudge.Repo,
      {DNSCluster, query: Application.get_env(:ai_drudge, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AiDrudge.PubSub},
      # Start a worker by calling: AiDrudge.Worker.start_link(arg)
      # {AiDrudge.Worker, arg},
      # Start to serve requests, typically the last entry
      AiDrudgeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AiDrudge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AiDrudgeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
