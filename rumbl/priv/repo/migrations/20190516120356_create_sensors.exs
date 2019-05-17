defmodule Rumbl.Repo.Migrations.CreateSensors do
  use Ecto.Migration

  def change do
    create table(:sensors) do
      add :latitude, :string
      add :longitude, :string
      add :river_id, references(:rivers, on_delete: :nothing)

      timestamps()
    end

    create index(:sensors, [:river_id])
  end
end
