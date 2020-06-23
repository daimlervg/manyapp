defmodule Manyapp.Configurations do
  @moduledoc """
  The Configurations context.
  """

  import Ecto.Query, warn: false
  alias Manyapp.Repo

  alias Manyapp.Configurations.Property

  @doc """
  Returns the list of properties.

  ## Examples

      iex> list_properties()
      [%Property{}, ...]

  """
  def list_properties do
    Repo.all(Property)
  end

  @doc """
  Gets a single property.

  Raises `Ecto.NoResultsError` if the Property does not exist.

  ## Examples

      iex> get_property!(123)
      %Property{}

      iex> get_property!(456)
      ** (Ecto.NoResultsError)

  """
  def get_property!(id) do  
    Repo.get!(Property, id)
    |> Repo.preload(:amenities)
  end

  @doc """
  Creates a property.

  ## Examples

      iex> create_property(%{field: value})
      {:ok, %Property{}}

      iex> create_property(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_property(attrs \\ %{}) do
    %Property{}
    |> Property.changeset(attrs)
    |> maybe_put_amenities(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a property.

  ## Examples

      iex> update_property(property, %{field: new_value})
      {:ok, %Property{}}

      iex> update_property(property, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_property(%Property{} = property, attrs) do
    property
    |> Property.changeset(attrs)
    |> maybe_put_amenities(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a property.

  ## Examples

      iex> delete_property(property)
      {:ok, %Property{}}

      iex> delete_property(property)
      {:error, %Ecto.Changeset{}}

  """
  def delete_property(%Property{} = property) do
    Repo.delete(property)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking property changes.

  ## Examples

      iex> change_property(property)
      %Ecto.Changeset{data: %Property{}}

  """
  def change_property(%Property{} = property, attrs \\ %{}) do
    Property.changeset(property, attrs) 
  end

 # defp maybe_put_amenities(changeset, []), do: changeset

  defp maybe_put_amenities(changeset, attrs) do
    amenities = get_amenities(attrs["amenities"])
    Ecto.Changeset.put_assoc(changeset, :amenities, amenities)
  end

  def load_amenities(property), do: Repo.preload(property, :amenities)

  alias Manyapp.Configurations.Amenity

  @doc """
  Returns the list of amenities.

  ## Examples

      iex> list_amenities()
      [%Amenity{}, ...]

  """
  def list_amenities do
    Repo.all(Amenity)
  end

  @doc """
  Gets a single amenity.

  Raises `Ecto.NoResultsError` if the Amenity does not exist.

  ## Examples

      iex> get_amenity!(123)
      %Amenity{}

      iex> get_amenity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_amenity!(id), do: Repo.get!(Amenity, id)

  @doc """
  Creates a amenity.

  ## Examples

      iex> create_amenity(%{field: value})
      {:ok, %Amenity{}}

      iex> create_amenity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_amenity(attrs \\ %{}) do
    %Amenity{}
    |> Amenity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a amenity.

  ## Examples

      iex> update_amenity(amenity, %{field: new_value})
      {:ok, %Amenity{}}

      iex> update_amenity(amenity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_amenity(%Amenity{} = amenity, attrs) do
    amenity
    |> Amenity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a amenity.

  ## Examples

      iex> delete_amenity(amenity)
      {:ok, %Amenity{}}

      iex> delete_amenity(amenity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_amenity(%Amenity{} = amenity) do
    Repo.delete(amenity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking amenity changes.

  ## Examples

      iex> change_amenity(amenity)
      %Ecto.Changeset{data: %Amenity{}}

  """
  def change_amenity(%Amenity{} = amenity, attrs \\ %{}) do
    Amenity.changeset(amenity, attrs)
  end

  #def get_amenities(nil), do: []

def get_amenities(ids) do
  Repo.all(from a in Amenity , where: a.id in ^ids)
end

end
