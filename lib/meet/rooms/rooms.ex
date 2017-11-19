defmodule Meet.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Meet.Repo

  alias Meet.Rooms.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end

  alias Meet.Rooms.Marker

  @doc """
  Returns the list of markers.

  ## Examples

      iex> list_markers()
      [%Marker{}, ...]

  """
  def list_markers do
    Repo.all(Marker)
  end

  @doc """
  Gets a single marker.

  Raises `Ecto.NoResultsError` if the Marker does not exist.

  ## Examples

      iex> get_marker!(123)
      %Marker{}

      iex> get_marker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_marker!(id), do: Repo.get!(Marker, id)

  @doc """
  Creates a marker.

  ## Examples

      iex> create_marker(%{field: value})
      {:ok, %Marker{}}

      iex> create_marker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_marker(attrs \\ %{}) do
    %Marker{}
    |> Marker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a marker.

  ## Examples

      iex> update_marker(marker, %{field: new_value})
      {:ok, %Marker{}}

      iex> update_marker(marker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_marker(%Marker{} = marker, attrs) do
    marker
    |> Marker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Marker.

  ## Examples

      iex> delete_marker(marker)
      {:ok, %Marker{}}

      iex> delete_marker(marker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_marker(%Marker{} = marker) do
    Repo.delete(marker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking marker changes.

  ## Examples

      iex> change_marker(marker)
      %Ecto.Changeset{source: %Marker{}}

  """
  def change_marker(%Marker{} = marker) do
    Marker.changeset(marker, %{})
  end
end
