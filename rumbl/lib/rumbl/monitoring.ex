defmodule Rumbl.Monitoring do
  @moduledoc """
  The Monitoring context.
  """

  import Ecto.Query, warn: false
  alias Rumbl.Repo
  alias Rumbl.World

  alias Rumbl.Monitoring.Sensor

  @doc """
  Returns the list of sensors.

  ## Examples

      iex> list_sensors()
      [%Sensor{}, ...]

  """
  def list_sensors do
    Sensor
    |> Repo.all()
    |> preload_river()
  end

  @doc """
  Gets a single sensor.

  Raises `Ecto.NoResultsError` if the Sensor does not exist.

  ## Examples

      iex> get_sensor!(123)
      %Sensor{}

      iex> get_sensor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sensor!(id), do: preload_river(Repo.get!(Sensor, id))

  @doc """
  Creates a sensor.

  ## Examples

      iex> create_sensor(%{field: value})
      {:ok, %Sensor{}}

      iex> create_sensor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  #def create_sensor(%World.River{} = river, attrs \\ %{}) do
  #  %Sensor{}
  #  |> Sensor.changeset(attrs)
  #  |> put_river(river)
  #  |> Repo.insert()
  #end

  def create_sensor(attrs \\ %{}) do
    %Sensor{}
    |> Sensor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sensor.

  ## Examples

      iex> update_sensor(sensor, %{field: new_value})
      {:ok, %Sensor{}}

      iex> update_sensor(sensor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sensor(%Sensor{} = sensor, attrs) do
    sensor
    |> Sensor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sensor.

  ## Examples

      iex> delete_sensor(sensor)
      {:ok, %Sensor{}}

      iex> delete_sensor(sensor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sensor(%Sensor{} = sensor) do
    Repo.delete(sensor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sensor changes.

  ## Examples

      iex> change_sensor(sensor)
      %Ecto.Changeset{source: %Sensor{}}

  """
#  def change_sensor(%World.River{} = river, %Sensor{} = sensor) do
#    sensor
#    |> Sensor.changeset(%{})
#    |> put_river(river)
#  end

  def change_sensor(%Sensor{} = sensor) do
    Sensor.changeset(sensor, %{})
  end

  defp put_river(changeset, river) do
    Ecto.Changeset.put_assoc(changeset, :river, river)
  end

  def list_river_sensors(%World.River{} = river) do
    Sensor
    |> river_sensors_query(river)
    |> Repo.all()
    |> preload_river()
  end

  def get_river_sensor!(%World.River{} = river, id) do
    from(v in Sensor, where: v.id == ^id)
    |> river_sensors_query(river)
    |> Repo.one!()
    |> preload_river()
  end

  defp river_sensors_query(query, %World.River{id: river_id}) do
    from(v in query, where: v.river_id == ^river_id)
  end

  defp preload_river(sensor_or_sensors) do
    Repo.preload(sensor_or_sensors, :river)
  end
end
