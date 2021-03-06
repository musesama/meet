defmodule MeetWeb.Router do
  use MeetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MeetWeb do
    pipe_through :browser # Use the default browser stack
    resources "/rooms", RoomController
    
    get "/", PageController, :index
  end

  scope "/api/v1", MeetWeb do
    pipe_through :api
    resources "/markers", MarkerController, except: [:new, :edit]
  end
end
