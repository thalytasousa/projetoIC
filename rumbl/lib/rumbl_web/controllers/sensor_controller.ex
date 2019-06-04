defmodule RumblWeb.SensorController do
  use RumblWeb, :controller

  alias Rumbl.Monitoring
  alias Rumbl.Monitoring.Sensor

  def index(conn, _params, current_user) do
    sensors = Monitoring.list_sensors()
    render(conn, "index.html", sensors: sensors)
  end

  def new(conn, _params, current_user) do
    changeset = Monitoring.change_sensor(current_user, %Sensor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sensor" => sensor_params}, current_user) do
    case Monitoring.create_sensor(current_user, sensor_params) do
      {:ok, sensor} ->
        conn
        |> put_flash(:info, "Sensor created successfully.")
        |> redirect(to: Routes.sensor_path(conn, :show, sensor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    sensor = Monitoring.get_river_sensor!(current_user, id)
    render(conn, "show.html", sensor: sensor)
  end

  def edit(conn, %{"id" => id}, current_user) do
    sensor = Monitoring.get_river_sensor!(current_user, id)
    changeset = Monitoring.change_sensor(current_user, sensor)
    render(conn, "edit.html", sensor: sensor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sensor" => sensor_params}, current_user) do
    sensor = Monitoring.get_river_sensor!(current_user, id)

    case Monitoring.update_sensor(sensor, sensor_params) do
      {:ok, sensor} ->
        conn
        |> put_flash(:info, "Sensor updated successfully.")
        |> redirect(to: Routes.sensor_path(conn, :show, sensor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sensor: sensor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    sensor = Monitoring.get_river_sensor!(current_user, id)
    {:ok, _sensor} = Monitoring.delete_sensor(sensor)

    conn
    |> put_flash(:info, "Sensor deleted successfully.")
    |> redirect(to: Routes.sensor_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
