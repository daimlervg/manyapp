defmodule Manyapp.Configurations.Property do
  use Ecto.Schema
  import Ecto.Changeset

  schema "properties" do
    field :name, :string
    many_to_many(:amenities, Manyapp.Configurations.Amenity, join_through: Manyapp.Configurations.PropertiesAmenities, on_replace: :delete)
    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
