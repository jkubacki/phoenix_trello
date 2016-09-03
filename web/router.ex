defmodule Fantasygame.Router do
  use Fantasygame.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Fantasygame do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create
    end
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Fantasygame do
    pipe_through :browser # Use the default browser stack

    get "*path", PageController, :index
  end
end
