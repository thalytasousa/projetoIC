defmodule Rumbl.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Rumbl.User



    schema "users" do
        field :name, :string
        field :username, :string
        field :password, :string, virtual: true
        field :password_hash, :string

        timestamps()
      end

      def changeset(%User{} = user, attrs \\ %{}) do
        user
        |> cast(attrs, [:name, :username, :password, :password_hash])
        |> validate_length(:username, min: 1)
        |> validate_length(:username, max: 20)
      end
end
