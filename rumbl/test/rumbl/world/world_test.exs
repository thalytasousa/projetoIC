defmodule Rumbl.WorldTest do
  use Rumbl.DataCase

  alias Rumbl.World

  describe "rivers" do
    alias Rumbl.World.River

    @valid_attrs %{cities: "some cities", name: "some name", states: "some states"}
    @update_attrs %{cities: "some updated cities", name: "some updated name", states: "some updated states"}
    @invalid_attrs %{cities: nil, name: nil, states: nil}

    def river_fixture(attrs \\ %{}) do
      {:ok, river} =
        attrs
        |> Enum.into(@valid_attrs)
        |> World.create_river()

      river
    end

    test "list_rivers/0 returns all rivers" do
      river = river_fixture()
      assert World.list_rivers() == [river]
    end

    test "get_river!/1 returns the river with given id" do
      river = river_fixture()
      assert World.get_river!(river.id) == river
    end

    test "create_river/1 with valid data creates a river" do
      assert {:ok, %River{} = river} = World.create_river(@valid_attrs)
      assert river.cities == "some cities"
      assert river.name == "some name"
      assert river.states == "some states"
    end

    test "create_river/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = World.create_river(@invalid_attrs)
    end

    test "update_river/2 with valid data updates the river" do
      river = river_fixture()
      assert {:ok, %River{} = river} = World.update_river(river, @update_attrs)
      assert river.cities == "some updated cities"
      assert river.name == "some updated name"
      assert river.states == "some updated states"
    end

    test "update_river/2 with invalid data returns error changeset" do
      river = river_fixture()
      assert {:error, %Ecto.Changeset{}} = World.update_river(river, @invalid_attrs)
      assert river == World.get_river!(river.id)
    end

    test "delete_river/1 deletes the river" do
      river = river_fixture()
      assert {:ok, %River{}} = World.delete_river(river)
      assert_raise Ecto.NoResultsError, fn -> World.get_river!(river.id) end
    end

    test "change_river/1 returns a river changeset" do
      river = river_fixture()
      assert %Ecto.Changeset{} = World.change_river(river)
    end
  end
end
