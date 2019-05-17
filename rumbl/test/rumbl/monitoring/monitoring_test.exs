defmodule Rumbl.MonitoringTest do
  use Rumbl.DataCase

  alias Rumbl.Monitoring

  describe "sensors" do
    alias Rumbl.Monitoring.Sensor

    @valid_attrs %{latitude: "some latitude", longitude: "some longitude"}
    @update_attrs %{latitude: "some updated latitude", longitude: "some updated longitude"}
    @invalid_attrs %{latitude: nil, longitude: nil}

    def sensor_fixture(attrs \\ %{}) do
      {:ok, sensor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Monitoring.create_sensor()

      sensor
    end

    test "list_sensors/0 returns all sensors" do
      sensor = sensor_fixture()
      assert Monitoring.list_sensors() == [sensor]
    end

    test "get_sensor!/1 returns the sensor with given id" do
      sensor = sensor_fixture()
      assert Monitoring.get_sensor!(sensor.id) == sensor
    end

    test "create_sensor/1 with valid data creates a sensor" do
      assert {:ok, %Sensor{} = sensor} = Monitoring.create_sensor(@valid_attrs)
      assert sensor.latitude == "some latitude"
      assert sensor.longitude == "some longitude"
    end

    test "create_sensor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitoring.create_sensor(@invalid_attrs)
    end

    test "update_sensor/2 with valid data updates the sensor" do
      sensor = sensor_fixture()
      assert {:ok, %Sensor{} = sensor} = Monitoring.update_sensor(sensor, @update_attrs)
      assert sensor.latitude == "some updated latitude"
      assert sensor.longitude == "some updated longitude"
    end

    test "update_sensor/2 with invalid data returns error changeset" do
      sensor = sensor_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitoring.update_sensor(sensor, @invalid_attrs)
      assert sensor == Monitoring.get_sensor!(sensor.id)
    end

    test "delete_sensor/1 deletes the sensor" do
      sensor = sensor_fixture()
      assert {:ok, %Sensor{}} = Monitoring.delete_sensor(sensor)
      assert_raise Ecto.NoResultsError, fn -> Monitoring.get_sensor!(sensor.id) end
    end

    test "change_sensor/1 returns a sensor changeset" do
      sensor = sensor_fixture()
      assert %Ecto.Changeset{} = Monitoring.change_sensor(sensor)
    end
  end
end
