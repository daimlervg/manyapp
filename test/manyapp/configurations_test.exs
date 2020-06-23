defmodule Manyapp.ConfigurationsTest do
  use Manyapp.DataCase

  alias Manyapp.Configurations

  describe "properties" do
    alias Manyapp.Configurations.Property

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def property_fixture(attrs \\ %{}) do
      {:ok, property} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Configurations.create_property()

      property
    end

    test "list_properties/0 returns all properties" do
      property = property_fixture()
      assert Configurations.list_properties() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert Configurations.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      assert {:ok, %Property{} = property} = Configurations.create_property(@valid_attrs)
      assert property.name == "some name"
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configurations.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()
      assert {:ok, %Property{} = property} = Configurations.update_property(property, @update_attrs)
      assert property.name == "some updated name"
    end

    test "update_property/2 with invalid data returns error changeset" do
      property = property_fixture()
      assert {:error, %Ecto.Changeset{}} = Configurations.update_property(property, @invalid_attrs)
      assert property == Configurations.get_property!(property.id)
    end

    test "delete_property/1 deletes the property" do
      property = property_fixture()
      assert {:ok, %Property{}} = Configurations.delete_property(property)
      assert_raise Ecto.NoResultsError, fn -> Configurations.get_property!(property.id) end
    end

    test "change_property/1 returns a property changeset" do
      property = property_fixture()
      assert %Ecto.Changeset{} = Configurations.change_property(property)
    end
  end

  describe "amenities" do
    alias Manyapp.Configurations.Amenity

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def amenity_fixture(attrs \\ %{}) do
      {:ok, amenity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Configurations.create_amenity()

      amenity
    end

    test "list_amenities/0 returns all amenities" do
      amenity = amenity_fixture()
      assert Configurations.list_amenities() == [amenity]
    end

    test "get_amenity!/1 returns the amenity with given id" do
      amenity = amenity_fixture()
      assert Configurations.get_amenity!(amenity.id) == amenity
    end

    test "create_amenity/1 with valid data creates a amenity" do
      assert {:ok, %Amenity{} = amenity} = Configurations.create_amenity(@valid_attrs)
      assert amenity.name == "some name"
    end

    test "create_amenity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configurations.create_amenity(@invalid_attrs)
    end

    test "update_amenity/2 with valid data updates the amenity" do
      amenity = amenity_fixture()
      assert {:ok, %Amenity{} = amenity} = Configurations.update_amenity(amenity, @update_attrs)
      assert amenity.name == "some updated name"
    end

    test "update_amenity/2 with invalid data returns error changeset" do
      amenity = amenity_fixture()
      assert {:error, %Ecto.Changeset{}} = Configurations.update_amenity(amenity, @invalid_attrs)
      assert amenity == Configurations.get_amenity!(amenity.id)
    end

    test "delete_amenity/1 deletes the amenity" do
      amenity = amenity_fixture()
      assert {:ok, %Amenity{}} = Configurations.delete_amenity(amenity)
      assert_raise Ecto.NoResultsError, fn -> Configurations.get_amenity!(amenity.id) end
    end

    test "change_amenity/1 returns a amenity changeset" do
      amenity = amenity_fixture()
      assert %Ecto.Changeset{} = Configurations.change_amenity(amenity)
    end
  end
end
