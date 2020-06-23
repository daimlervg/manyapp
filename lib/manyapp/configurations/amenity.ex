defmodule Manyapp.Configurations.Amenity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "amenities" do
    field :name, :string
    many_to_many(:properties, Manyapp.Configurations.Property, join_through: Manyapp.Configurations.PropertiesAmenities, on_replace: :delete)
    timestamps()
  end

  @doc false
  def changeset(amenity, attrs) do
    amenity
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
