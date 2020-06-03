defmodule PlateSlate.Ordering.MenuItem do
  use Ecto.Schema

  schema "items" do
    field :name, :string
    field :price, :decimal

    timestamps()
  end
end
