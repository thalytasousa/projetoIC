defmodule RumblWeb.SensorController do
  use RumblWeb, :controller

  alias Rumbl.Monitoring
  alias Rumbl.Monitoring.Sensor

  def index(conn, _params, current_river) do
    sensors = Monitoring.list_river_sensors(current_river)
    render(conn, "index.html", sensors: sensors)
  end

  def new(conn, _params, current_river) do
    changeset = Monitoring.change_sensor(current_river, %Sensor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sensor" => sensor_params}, current_river) do
    case Monitoring.create_sensor(current_river, sensor_params) do
      {:ok, sensor} ->
        conn
        |> put_flash(:info, "Sensor created successfully.")
        |> redirect(to: Routes.sensor_path(conn, :show, sensor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_river) do
    sensor = Monitoring.get_river_sensor!(current_river, id)
    render(conn, "show.html", sensor: sensor)
  end

  def edit(conn, %{"id" => id}, current_river) do
    sensor = Monitoring.get_river_sensor!(current_river, id)
    changeset = Monitoring.change_sensor(current_river, sensor)
    render(conn, "edit.html", sensor: sensor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sensor" => sensor_params}, current_river) do
    sensor = Monitoring.get_river_sensor!(current_river, id)

    case Monitoring.update_sensor(sensor, sensor_params) do
      {:ok, sensor} ->
        conn
        |> put_flash(:info, "Sensor updated successfully.")
        |> redirect(to: Routes.sensor_path(conn, :show, sensor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sensor: sensor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_river) do
    sensor = Monitoring.get_river_sensor!(current_river, id)
    {:ok, _sensor} = Monitoring.delete_sensor(sensor)

    conn
    |> put_flash(:info, "Sensor deleted successfully.")
    |> redirect(to: Routes.sensor_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user] #args = [conn, conn.params, conn.assigns.current_river]
    apply(__MODULE__, action_name(conn), args)
  end
end
