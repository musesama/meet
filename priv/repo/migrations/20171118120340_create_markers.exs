defmodule Meet.Repo.Migrations.CreateMarkers do
  use Ecto.Migration

  def change do
    create table(:markers) do
      add :lon, :float
      add :lat, :float
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:markers, [:room_id])
  end
end
