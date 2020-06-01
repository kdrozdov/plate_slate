defmodule PlateSlate.Ordering do
  @moduledoc """
  The Ordering context.
  """

  alias PlateSlate.Ordering.{Order, OrderRepo}

  def list_orders(), do: OrderRepo.list()

  def get_order!(id), do: OrderRepo.get!(id)

  def create_order(attrs \\ %{}), do: OrderRepo.create(attrs)

  def update_order(%Order{} = order, attrs), do: OrderRepo.update(order, attrs)

  def delete_order(%Order{} = order), do: OrderRepo.delete(order)

  def change_order(%Order{} = order), do: OrderRepo.change(order)
end
