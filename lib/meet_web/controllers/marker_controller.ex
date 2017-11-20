defmodule MeetWeb.MarkerController do
  use MeetWeb, :controller

  alias Meet.Rooms
  alias Meet.Rooms.Marker

  action_fallback MeetWeb.FallbackController

  def index(conn, %{"room_id" => room_id}) do
    {r_id, _} = Integer.parse room_id
    markers = Rooms.list_markers() |> Enum.filter(fn
      %{:room_id => ^r_id} -> true
      _ -> false
    end)
    render(conn, "index.json", markers: markers)
  end

  def index(conn, _params) do
    markers = Rooms.list_markers()
    render(conn, "index.json", markers: markers)
  end

  def create(conn, %{"marker" => marker_params}) do
    with {:ok, %Marker{} = marker} <- Rooms.create_marker(marker_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", marker_path(conn, :show, marker))
      |> render("show.json", marker: marker)
    end
  end

  def show(conn, %{"id" => id}) do
    marker = Rooms.get_marker!(id)
    render(conn, "show.json", marker: marker)
  end

  def update(conn, %{"id" => id, "marker" => marker_params}) do
    marker = Rooms.get_marker!(id)

    with {:ok, %Marker{} = marker} <- Rooms.update_marker(marker, marker_params) do
      render(conn, "show.json", marker: marker)
    end
  end

  def delete(conn, %{"id" => id}) do
    marker = Rooms.get_marker!(id)
    with {:ok, %Marker{}} <- Rooms.delete_marker(marker) do
      send_resp(conn, :no_content, "")
    end
  end
end
