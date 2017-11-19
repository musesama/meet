defmodule Meet.Rooms.Marker do
  use Ecto.Schema
  import Ecto.Changeset
  alias Meet.Rooms.Marker


  schema "markers" do
    field :lat, :float
    field :lon, :float
    field :room_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Marker{} = marker, attrs) do
    marker
    |> cast(attrs, [:lon, :lat])
    |> validate_required([:lon, :lat])
  end
end
