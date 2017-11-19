defmodule MeetWeb.MarkerControllerTest do
  use MeetWeb.ConnCase

  alias Meet.Rooms
  alias Meet.Rooms.Marker

  @create_attrs %{lat: 120.5, lon: 120.5}
  @update_attrs %{lat: 456.7, lon: 456.7}
  @invalid_attrs %{lat: nil, lon: nil}

  def fixture(:marker) do
    {:ok, marker} = Rooms.create_marker(@create_attrs)
    marker
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all markers", %{conn: conn} do
      conn = get conn, marker_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create marker" do
    test "renders marker when data is valid", %{conn: conn} do
      conn = post conn, marker_path(conn, :create), marker: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, marker_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "lat" => 120.5,
        "lon" => 120.5}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, marker_path(conn, :create), marker: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update marker" do
    setup [:create_marker]

    test "renders marker when data is valid", %{conn: conn, marker: %Marker{id: id} = marker} do
      conn = put conn, marker_path(conn, :update, marker), marker: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, marker_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "lat" => 456.7,
        "lon" => 456.7}
    end

    test "renders errors when data is invalid", %{conn: conn, marker: marker} do
      conn = put conn, marker_path(conn, :update, marker), marker: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete marker" do
    setup [:create_marker]

    test "deletes chosen marker", %{conn: conn, marker: marker} do
      conn = delete conn, marker_path(conn, :delete, marker)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, marker_path(conn, :show, marker)
      end
    end
  end

  defp create_marker(_) do
    marker = fixture(:marker)
    {:ok, marker: marker}
  end
end
