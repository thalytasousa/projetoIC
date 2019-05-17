defmodule Rumbl.World do
  @moduledoc """
  The World context.
  """

  import Ecto.Query, warn: false
  alias Rumbl.Repo

  alias Rumbl.World.River

  @doc """
  Returns the list of rivers.

  ## Examples

      iex> list_rivers()
      [%River{}, ...]

  """
  def list_rivers do
    Repo.all(River)
  end

  @doc """
  Gets a single river.

  Raises `Ecto.NoResultsError` if the River does not exist.

  ## Examples

      iex> get_river!(123)
      %River{}

      iex> get_river!(456)
      ** (Ecto.NoResultsError)

  """
  def get_river!(id), do: Repo.get!(River, id)

  @doc """
  Creates a river.

  ## Examples

      iex> create_river(%{field: value})
      {:ok, %River{}}

      iex> create_river(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_river(attrs \\ %{}) do
    %River{}
    |> River.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a river.

  ## Examples

      iex> update_river(river, %{field: new_value})
      {:ok, %River{}}

      iex> update_river(river, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_river(%River{} = river, attrs) do
    river
    |> River.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a River.

  ## Examples

      iex> delete_river(river)
      {:ok, %River{}}

      iex> delete_river(river)
      {:error, %Ecto.Changeset{}}

  """
  def delete_river(%River{} = river) do
    Repo.delete(river)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking river changes.

  ## Examples

      iex> change_river(river)
      %Ecto.Changeset{source: %River{}}

  """
  def change_river(%River{} = river) do
    River.changeset(river, %{})
  end
end
