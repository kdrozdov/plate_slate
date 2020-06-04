defmodule PlateSlateWeb.Plugs.Context do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    IO.inspect(context: context)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- PlateSlateWeb.Authentication.verify(token),
         {:ok, user} <- get_user(data) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end

  defp get_user(%{id: _id, role: _role} = params) do
    PlateSlate.Accounts.get_by(params)
  end
end
