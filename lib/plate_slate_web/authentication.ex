defmodule PlateSlateWeb.Authentication do
  @token_salt Application.compile_env!(:plate_slate, :token_salt)
  @max_age Application.compile_env!(:plate_slate, :token_max_age)

  def sign(data) do
    Phoenix.Token.sign(PlateSlateWeb.Endpoint, @token_salt, data)
  end

  def verify(token) do
    Phoenix.Token.verify(
      PlateSlateWeb.Endpoint,
      @token_salt,
      token,
      max_age: @max_age
    )
  end
end
