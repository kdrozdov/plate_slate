defmodule Factory do
  def create_user(role) do
    int = :erlang.unique_integer([:positive, :monotonic])

    params = %{
      name: "Person #{int}",
      email: "fake-#{int}@example.com",
      password: "super-secret",
      role: role
    }

    {:ok, user} = PlateSlate.Accounts.create_user(params)
    user
  end
end
