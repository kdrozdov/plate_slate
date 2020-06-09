defmodule PlateSlate.Menu do
  @moduledoc """
  The Menu context.
  """

  alias PlateSlate.Menu.{Item, ItemRepo, CategoryRepo}

  def list_items(criteria \\ %{}), do: ItemRepo.list(criteria)

  def get_item!(id), do: ItemRepo.get!(id)

  def create_item(attrs \\ %{}), do: ItemRepo.create(attrs)

  def update_item(%Item{} = item, attrs), do: ItemRepo.update(item, attrs)

  def delete_item(%Item{} = item), do: ItemRepo.delete(item)

  def change_item(%Item{} = item), do: ItemRepo.change(item)

  @repos_for_search [ItemRepo, CategoryRepo]
  def search(term) do
    Enum.flat_map(@repos_for_search, fn repo ->
      apply(repo, :search, [term])
    end)
  end

  def get_category!(id), do: CategoryRepo.get!(id)

  def get_category_by(params \\ %{}), do: CategoryRepo.get_by(params)

  def data() do
    Dataloader.Ecto.new(PlateSlate.Repo, query: &query/2)
  end

  def query(Item, args), do: ItemRepo.list_query(args)
  def query(queryable, _), do: queryable
end
