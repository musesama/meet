defmodule MeetWeb.PageController do
  use MeetWeb, :controller

  def index(conn, _params) do
    redirect conn, to: room_path(conn, :index)
  end
end
