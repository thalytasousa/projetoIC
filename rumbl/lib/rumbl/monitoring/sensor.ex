defmodule Rumbl.Monitoring.Sensor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sensors" do
    field :latitude, :string
    field :longitude, :string
    belongs_to :river, Rumbl.World.River

    timestamps()
  end

  @doc false
  def changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:latitude, :longitude])
    |> validate_required([:latitude, :longitude])
    |> validate_length(:username, min: 1, max: 20)
  end
end
