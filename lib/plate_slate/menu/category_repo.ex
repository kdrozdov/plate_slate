defmodule PlateSlate.Menu.CategoryRepo do
  import Ecto.Query

  alias PlateSlate.Repo
  alias PlateSlate.Menu.Category

  def search(term) do
    pattern = "%#{term}%"

    (from i in Category)
    |> where([i], ilike(i.name, ^pattern) or ilike(i.description, ^pattern))
    |> Repo.all()
  end

end
