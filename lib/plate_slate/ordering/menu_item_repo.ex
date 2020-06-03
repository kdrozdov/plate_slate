defmodule PlateSlate.Ordering.MenuItemRepo do
  alias PlateSlate.Repo
  alias PlateSlate.Ordering.MenuItem

  def get!(id), do: Repo.get!(MenuItem, id)
end
