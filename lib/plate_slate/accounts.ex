defmodule PlateSlate.Users do
  @moduledoc """
  The User context.
  """

  alias PlateSlate.Accounts.{User, UserRepo, Authentication}

  def list_users(), do: UserRepo.list()

  def get_user!(id), do: UserRepo.get!(id)

  def create_user(attrs \\ %{}), do: UserRepo.create(attrs)

  def update_user(%User{} = account, attrs), do: UserRepo.update(account, attrs)

  def delete_user(%User{} = account), do: UserRepo.delete(account)

  def change_user(%User{} = account), do: UserRepo.change(account)

  defdelegate authenticate(role, email, password), to: Authentication
end

