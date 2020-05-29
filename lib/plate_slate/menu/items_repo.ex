defmodule PlateSlate.Menu.ItemsRepo do
  import Ecto.Query

  alias PlateSlate.Repo
  alias PlateSlate.Menu.Item

  def list(criteria \\ %{}) do
    query = from i in Item

    Map.keys(criteria)
    |> Enum.map(fn key -> {key, Map.get(criteria, key)} end)
    |> Enum.reduce(query, &compose_query/2)
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

  defp compose_query(_, query), do: query
end

