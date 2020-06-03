defmodule PlateSlate.Accounts.Authentication do
  alias PlateSlate.Accounts.UserRepo

  def authenticate(role, email, password) do
    user = UserRepo.get_by(role: to_string(role), email: email)

    with %{encrypted_password: digest} <- user,
         true <- Argon2.verify_pass(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end
end
