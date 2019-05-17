defmodule Rumbl.Repo.Migrations.CreateRivers do
  use Ecto.Migration

  def change do
    create table(:rivers) do
      add :states, :text
      add :cities, :text
      add :name, :string

      timestamps()
    end

  end
end
