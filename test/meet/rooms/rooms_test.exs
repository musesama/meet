defmodule Meet.RoomsTest do
  use Meet.DataCase

  alias Meet.Rooms

  describe "rooms" do
    alias Meet.Rooms.Room

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Rooms.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Rooms.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Rooms.create_room(@valid_attrs)
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, room} = Rooms.update_room(room, @update_attrs)
      assert %Room{} = room
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_room(room, @invalid_attrs)
      assert room == Rooms.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Rooms.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Rooms.change_room(room)
    end
  end

  describe "markers" do
    alias Meet.Rooms.Marker

    @valid_attrs %{lat: 120.5, lon: 120.5}
    @update_attrs %{lat: 456.7, lon: 456.7}
    @invalid_attrs %{lat: nil, lon: nil}

    def marker_fixture(attrs \\ %{}) do
      {:ok, marker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_marker()

      marker
    end

    test "list_markers/0 returns all markers" do
      marker = marker_fixture()
      assert Rooms.list_markers() == [marker]
    end

    test "get_marker!/1 returns the marker with given id" do
      marker = marker_fixture()
      assert Rooms.get_marker!(marker.id) == marker
    end

    test "create_marker/1 with valid data creates a marker" do
      assert {:ok, %Marker{} = marker} = Rooms.create_marker(@valid_attrs)
      assert marker.lat == 120.5
      assert marker.lon == 120.5
    end

    test "create_marker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_marker(@invalid_attrs)
    end

    test "update_marker/2 with valid data updates the marker" do
      marker = marker_fixture()
      assert {:ok, marker} = Rooms.update_marker(marker, @update_attrs)
      assert %Marker{} = marker
      assert marker.lat == 456.7
      assert marker.lon == 456.7
    end

    test "update_marker/2 with invalid data returns error changeset" do
      marker = marker_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_marker(marker, @invalid_attrs)
      assert marker == Rooms.get_marker!(marker.id)
    end

    test "delete_marker/1 deletes the marker" do
      marker = marker_fixture()
      assert {:ok, %Marker{}} = Rooms.delete_marker(marker)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_marker!(marker.id) end
    end

    test "change_marker/1 returns a marker changeset" do
      marker = marker_fixture()
      assert %Ecto.Changeset{} = Rooms.change_marker(marker)
    end
  end
end
