defmodule RumblWeb.RiverController do
  use RumblWeb, :controller

  alias Rumbl.World
  alias Rumbl.World.River

  def index(conn, _params) do
    rivers = World.list_rivers()
    render(conn, "index.html", rivers: rivers)
  end

  def new(conn, _params) do
    changeset = World.change_river(%River{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"river" => river_params}) do
    case World.create_river(river_params) do
      {:ok, river} ->
        conn
        |> put_flash(:info, "River created successfully.")
        |> redirect(to: Routes.river_path(conn, :show, river))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    river = World.get_river!(id)
    render(conn, "show.html", river: river)
  end

  def edit(conn, %{"id" => id}) do
    river = World.get_river!(id)
    changeset = World.change_river(river)
    render(conn, "edit.html", river: river, changeset: changeset)
  end

  def update(conn, %{"id" => id, "river" => river_params}) do
    river = World.get_river!(id)

    case World.update_river(river, river_params) do
      {:ok, river} ->
        conn
        |> put_flash(:info, "River updated successfully.")
        |> redirect(to: Routes.river_path(conn, :show, river))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", river: river, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    river = World.get_user_river!(current_user, id)
    {:ok, _river} = World.delete_river(river)

    conn
    |> put_flash(:info, "River deleted successfully.")
    |> redirect(to: Routes.river_path(conn, :index))
  end
end

#def delete(conn, %{"id" => id}) do
#  river = World.get_river!(id)
#  {:ok, _river} = World.delete_river(river)

#  conn
#  |> put_flash(:info, "River deleted successfully.")
#  |> redirect(to: Routes.river_path(conn, :index))
#end
