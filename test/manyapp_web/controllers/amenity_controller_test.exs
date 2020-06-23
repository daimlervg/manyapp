defmodule ManyappWeb.AmenityControllerTest do
  use ManyappWeb.ConnCase

  alias Manyapp.Configurations

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:amenity) do
    {:ok, amenity} = Configurations.create_amenity(@create_attrs)
    amenity
  end

  describe "index" do
    test "lists all amenities", %{conn: conn} do
      conn = get(conn, Routes.amenity_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Amenities"
    end
  end

  describe "new amenity" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.amenity_path(conn, :new))
      assert html_response(conn, 200) =~ "New Amenity"
    end
  end

  describe "create amenity" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.amenity_path(conn, :create), amenity: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.amenity_path(conn, :show, id)

      conn = get(conn, Routes.amenity_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Amenity"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.amenity_path(conn, :create), amenity: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Amenity"
    end
  end

  describe "edit amenity" do
    setup [:create_amenity]

    test "renders form for editing chosen amenity", %{conn: conn, amenity: amenity} do
      conn = get(conn, Routes.amenity_path(conn, :edit, amenity))
      assert html_response(conn, 200) =~ "Edit Amenity"
    end
  end

  describe "update amenity" do
    setup [:create_amenity]

    test "redirects when data is valid", %{conn: conn, amenity: amenity} do
      conn = put(conn, Routes.amenity_path(conn, :update, amenity), amenity: @update_attrs)
      assert redirected_to(conn) == Routes.amenity_path(conn, :show, amenity)

      conn = get(conn, Routes.amenity_path(conn, :show, amenity))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, amenity: amenity} do
      conn = put(conn, Routes.amenity_path(conn, :update, amenity), amenity: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Amenity"
    end
  end

  describe "delete amenity" do
    setup [:create_amenity]

    test "deletes chosen amenity", %{conn: conn, amenity: amenity} do
      conn = delete(conn, Routes.amenity_path(conn, :delete, amenity))
      assert redirected_to(conn) == Routes.amenity_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.amenity_path(conn, :show, amenity))
      end
    end
  end

  defp create_amenity(_) do
    amenity = fixture(:amenity)
    %{amenity: amenity}
  end
end
