defmodule PlateSlate.Ordering.OrderRepo do
  import Ecto.Query, warn: false
  alias PlateSlate.Repo

  alias PlateSlate.Ordering.Order

  def list do
    Repo.all(Order)
  end

  def get!(id), do: Repo.get!(Order, id)

  def create(attrs \\ %{}) do
    attrs = Map.update(attrs, :items, [], &build_items/1)

    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Order{} = order, attrs) do
    # attrs = Map.update(attrs, :items, [], &build_items/1)

    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Order{} = order) do
    Repo.delete(order)
  end

  def change(%Order{} = order) do
    Order.changeset(order, %{})
  end

  def customer_orders(customer_id) do
    Order
    |> where(customer_id: ^customer_id)
    |> Repo.all()
  end

  defp build_items(items) do
    for item <- items do
      menu_item = PlateSlate.Ordering.MenuItemRepo.get!(item.menu_item_id)
      %{name: menu_item.name, quantity: item.quantity, price: menu_item.price}
    end
  end
end
