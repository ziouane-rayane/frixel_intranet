defmodule FrixelIntranet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FrixelIntranetWeb.Telemetry,
      FrixelIntranet.Repo,
      {DNSCluster, query: Application.get_env(:frixel_intranet, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FrixelIntranet.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FrixelIntranet.Finch},
      # Start a worker by calling: FrixelIntranet.Worker.start_link(arg)
      # {FrixelIntranet.Worker, arg},
      # Start to serve requests, typically the last entry
      FrixelIntranetWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FrixelIntranet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FrixelIntranetWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
