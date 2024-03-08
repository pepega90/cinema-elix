defmodule Bioskop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BioskopWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bioskop.PubSub},
      # Start the Endpoint (http/https)
      BioskopWeb.Endpoint
      # Start a worker by calling: Bioskop.Worker.start_link(arg)
      # {Bioskop.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bioskop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BioskopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
