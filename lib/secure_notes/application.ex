defmodule SecureNotes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SecureNotesWeb.Telemetry,
      SecureNotes.Repo,
      {DNSCluster, query: Application.get_env(:secure_notes, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SecureNotes.PubSub},
      # Start a worker by calling: SecureNotes.Worker.start_link(arg)
      # {SecureNotes.Worker, arg},
      # Start to serve requests, typically the last entry
      SecureNotesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SecureNotes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SecureNotesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
