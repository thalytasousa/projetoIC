defmodule Rumbl.World.River do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rivers" do
    field :cities, :string
    field :name, :string
    field :states, :string

    timestamps()
  end

  @doc false
  def changeset(river, attrs) do
    river
    |> cast(attrs, [:states, :cities, :name])
    |> validate_required([:states, :cities, :name])
  end
end
