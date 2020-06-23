defmodule Manyapp.Repo.Migrations.CreatePropertiesAmenities do
  use Ecto.Migration

  def change do
    create table(:properties_amenities) do
      add :property_id, references(:properties)
      add :amenity_id, references(:amenities)
    end
    create unique_index(:properties_amenities, [:property_id, :amenity_id])
  end
end
