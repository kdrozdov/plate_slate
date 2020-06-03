defmodule PlateSlate.Accounts.UserRepo do
  import Ecto.Query, warn: false
  alias PlateSlate.Repo

  alias PlateSlate.Accounts.User

  def list(), do: Repo.all(User)

  def get!(id), do: Repo.get!(User, id)

  def get_by(attrs) do
    %User{}
    |> Repo.get_by(attrs)
  end

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete(%User{} = user) do
    Repo.delete(user)
  end

  def change(%User{} = user) do
    Order.changeset(user, %{})
  end
end

