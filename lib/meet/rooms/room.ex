defmodule Meet.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Meet.Rooms.Room


  schema "rooms" do

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [])
    |> validate_required([])
  end
end
