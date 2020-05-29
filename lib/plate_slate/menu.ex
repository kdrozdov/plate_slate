defmodule PlateSlate.Menu do
  @moduledoc """
  The Menu context.
  """

  alias PlateSlate.Menu.{Item, ItemsRepo}

  def list_items(criteria \\ %{}), do: ItemsRepo.list(criteria)

  def get_item!(id), do: ItemsRepo.get!(id)

  def create_item(attrs \\ %{}), do: ItemsRepo.create(attrs)

  def update_item(%Item{} = item, attrs), do: ItemsRepo.update(item, attrs)

  def delete_item(%Item{} = item), do: ItemsRepo.delete(item)

  def change_item(%Item{} = item), do: ItemsRepo.change(item)
end

