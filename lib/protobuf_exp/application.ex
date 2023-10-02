defmodule ProtobufExp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ProtobufExpWeb.Telemetry,
      # Start the Ecto repository
      ProtobufExp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ProtobufExp.PubSub},
      # Start Finch
      {Finch, name: ProtobufExp.Finch},
      # Start the Endpoint (http/https)
      ProtobufExpWeb.Endpoint
      # Start a worker by calling: ProtobufExp.Worker.start_link(arg)
      # {ProtobufExp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProtobufExp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProtobufExpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
