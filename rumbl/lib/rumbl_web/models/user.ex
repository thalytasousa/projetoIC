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

      #def registration_changeset(model, params) do
    #    model
    #    |> changeset(params)
    #    |> cast(params, ~w(password), [])
    #    |> validate_length(:password, min: 6)
    #    |> validate_length(:password, max: 100)
    #    |> put_pass_hash()

    #    end


end
