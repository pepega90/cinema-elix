defmodule BioskopWeb.Router do
  use BioskopWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BioskopWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BioskopWeb do
    pipe_through :browser

    live "/", Live.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BioskopWeb do
  #   pipe_through :api
  # end
end
