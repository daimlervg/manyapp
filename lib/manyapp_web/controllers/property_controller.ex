defmodule ManyappWeb.PropertyController do
  use ManyappWeb, :controller

  alias Manyapp.Configurations
  alias Manyapp.Configurations.Property

  def index(conn, _params) do
    properties = Configurations.list_properties()
    render(conn, "index.html", properties: properties)
  end

  def new(conn, _params) do
    changeset = Configurations.change_property(%Property{})
    amenities = Configurations.list_amenities()
    data = Configurations.load_amenities(changeset.data)

    render(conn, "new.html", changeset: %{changeset | data: data}, amenities: amenities)
  end

  def create(conn, %{"property" => property_params}) do
    case Configurations.create_property(property_params) do
      {:ok, property} ->
        conn
        |> put_flash(:info, "Property created successfully.")
        |> redirect(to: Routes.property_path(conn, :show, property))

      {:error, %Ecto.Changeset{} = changeset} ->
        data = Configurations.load_amenities(changeset.data)
        amenities = Configurations.list_amenities()

        conn
        |> put_flash(:error, "Error!")
        render(conn, "new.html", changeset: %{changeset | data: data}, amenities: amenities)
    end
  end

  def show(conn, %{"id" => id}) do
    property = Configurations.get_property!(id)
    render(conn, "show.html", property: property)
  end

  def edit(conn, %{"id" => id}) do
    property = Configurations.get_property!(id)
    amenities = Configurations.list_amenities()
    changeset = Configurations.change_property(property)
    render(conn, "edit.html", property: property, changeset: changeset, amenities: amenities)
  end

  def update(conn, %{"id" => id, "property" => property_params}) do
    property = Configurations.get_property!(id)

    case Configurations.update_property(property, property_params) do
      {:ok, property} ->
        conn
        |> put_flash(:info, "Property updated successfully.")
        |> redirect(to: Routes.property_path(conn, :show, property))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", property: property, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    property = Configurations.get_property!(id)
    {:ok, _property} = Configurations.delete_property(property)

    conn
    |> put_flash(:info, "Property deleted successfully.")
    |> redirect(to: Routes.property_path(conn, :index))
  end
end
