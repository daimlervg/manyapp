defmodule ManyappWeb.AmenityController do
  use ManyappWeb, :controller

  alias Manyapp.Configurations
  alias Manyapp.Configurations.Amenity

  def index(conn, _params) do
    amenities = Configurations.list_amenities()
    render(conn, "index.html", amenities: amenities)
  end

  def new(conn, _params) do
    changeset = Configurations.change_amenity(%Amenity{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"amenity" => amenity_params}) do
    case Configurations.create_amenity(amenity_params) do
      {:ok, amenity} ->
        conn
        |> put_flash(:info, "Amenity created successfully.")
        |> redirect(to: Routes.amenity_path(conn, :show, amenity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    amenity = Configurations.get_amenity!(id)
    render(conn, "show.html", amenity: amenity)
  end

  def edit(conn, %{"id" => id}) do
    amenity = Configurations.get_amenity!(id)
    changeset = Configurations.change_amenity(amenity)
    render(conn, "edit.html", amenity: amenity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "amenity" => amenity_params}) do
    amenity = Configurations.get_amenity!(id)

    case Configurations.update_amenity(amenity, amenity_params) do
      {:ok, amenity} ->
        conn
        |> put_flash(:info, "Amenity updated successfully.")
        |> redirect(to: Routes.amenity_path(conn, :show, amenity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", amenity: amenity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    amenity = Configurations.get_amenity!(id)
    {:ok, _amenity} = Configurations.delete_amenity(amenity)

    conn
    |> put_flash(:info, "Amenity deleted successfully.")
    |> redirect(to: Routes.amenity_path(conn, :index))
  end
end
