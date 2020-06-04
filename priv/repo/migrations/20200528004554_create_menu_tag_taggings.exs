defmodule PlateSlate.Repo.Migrations.CreateMenuTagTaggings do
  defp encrypt_password(changeset) do
    case Map.fetch(changeset.changes, :password) do
      {:ok, password} ->
        put_change(
          changeset,
          :encrypted_password,
          Argon2.hash_pwd_salt(password)
        )

      _ ->
        changeset
    end
  end

  use Ecto.Migration

  def change do
    create table(:items_taggings, primary_key: false) do
      add :item_id, references(:items), null: false
      add :item_tag_id, references(:item_tags), null: false
    end
  end
end
