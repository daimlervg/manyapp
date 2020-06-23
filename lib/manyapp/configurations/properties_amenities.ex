defmodule Manyapp.Configurations.PropertiesAmenities do
    use Ecto.Schema
    import Ecto.Changeset
  
    @primary_key false
  schema "properties_amenities" do
    belongs_to :property, Manyapp.Configurations.Property
    belongs_to :amenity, Manyapp.Configurations.Amenity
  end
  
    @doc false
    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:property_id, :amenity_id])
        |> validate_required([:property_id, :amenity_id])
      end
  end