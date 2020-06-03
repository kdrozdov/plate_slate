defmodule PlateSlate.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :role])
    |> validate_required([:name, :email, :password, :role])
    |> validate_length(:password, min: 4)
    |> unique_constraint(:email, name: :users_email_role_index)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case Map.fetch(changeset.changes, :password) do
      {:ok, password} ->
        hashed_password = Argon2.hash_pwd_salt(password)
        put_change(changeset, :encrypted_password, hashed_password)
      _ ->
        changeset
    end
  end

end
