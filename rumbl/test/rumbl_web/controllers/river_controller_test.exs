defmodule RumblWeb.RiverControllerTest do
  use RumblWeb.ConnCase

  alias Rumbl.World

  @create_attrs %{cities: "some cities", name: "some name", states: "some states"}
  @update_attrs %{cities: "some updated cities", name: "some updated name", states: "some updated states"}
  @invalid_attrs %{cities: nil, name: nil, states: nil}

  def fixture(:river) do
    {:ok, river} = World.create_river(@create_attrs)
    river
  end

  describe "index" do
    test "lists all rivers", %{conn: conn} do
      conn = get(conn, Routes.river_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rivers"
    end
  end

  describe "new river" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.river_path(conn, :new))
      assert html_response(conn, 200) =~ "New River"
    end
  end

  describe "create river" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.river_path(conn, :create), river: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.river_path(conn, :show, id)

      conn = get(conn, Routes.river_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show River"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.river_path(conn, :create), river: @invalid_attrs)
      assert html_response(conn, 200) =~ "New River"
    end
  end

  describe "edit river" do
    setup [:create_river]

    test "renders form for editing chosen river", %{conn: conn, river: river} do
      conn = get(conn, Routes.river_path(conn, :edit, river))
      assert html_response(conn, 200) =~ "Edit River"
    end
  end

  describe "update river" do
    setup [:create_river]

    test "redirects when data is valid", %{conn: conn, river: river} do
      conn = put(conn, Routes.river_path(conn, :update, river), river: @update_attrs)
      assert redirected_to(conn) == Routes.river_path(conn, :show, river)

      conn = get(conn, Routes.river_path(conn, :show, river))
      assert html_response(conn, 200) =~ "some updated cities"
    end

    test "renders errors when data is invalid", %{conn: conn, river: river} do
      conn = put(conn, Routes.river_path(conn, :update, river), river: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit River"
    end
  end

  describe "delete river" do
    setup [:create_river]

    test "deletes chosen river", %{conn: conn, river: river} do
      conn = delete(conn, Routes.river_path(conn, :delete, river))
      assert redirected_to(conn) == Routes.river_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.river_path(conn, :show, river))
      end
    end
  end

  defp create_river(_) do
    river = fixture(:river)
    {:ok, river: river}
  end
end
