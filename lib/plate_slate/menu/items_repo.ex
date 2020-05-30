defmodule PlateSlate.Menu.ItemsRepo do
  import Ecto.Query

  alias PlateSlate.Repo
  alias PlateSlate.Menu.Item

  def list(args \\ %{}) do
    query = from i in Item

    args
    |> Enum.reduce(query, fn
      {:order, order}, query ->
        query |> order_by({^order, :name})
      {:filter, filter}, query ->
        filter |> Enum.reduce(query, &compose_query/2)
    end)
    |> Repo.all()
  end

  def get!(id), do: Repo.get!(Item, id)

  def create(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Item{} = item) do
    Repo.delete(item)
  end

  def change(%Item{} = item) do
    Item.changeset(item, %{})
  end

  defp compose_query({:name, name}, query) do
    where(query, [i], ilike(i.name, ^"%#{name}%"))
  end

  defp compose_query({:price_above, price}, query) do
    where(query, [i], i.price >= ^price)
  end

  defp compose_query({:price_below, price}, query) do
    where(query, [i], i.price <= ^price)
  end

  defp compose_query({:category, category_name}, query) do
    query
    |> join(:inner, [i], c in assoc(i, :category), as: :category)
    |> where([i, category: c], c.name == ^category_name)
  end

  defp compose_query({:tag, tag_name}, query) do
    query
    |> join(:inner, [i], t in assoc(i, :tags), as: :tag)
    |> where([i, tag: t], ilike(t.name, ^"%#{tag_name}"))
  end

  defp compose_query(_, query), do: query
end

