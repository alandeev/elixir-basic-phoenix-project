defmodule CrudWeb.Middlewares.Authorizer do
  use CrudWeb, :controller

  import Plug.Conn
  import Phoenix.Token

  @signing_salt "secret_md5"

  def call(conn, _default) do
    {_, token} = List.keyfind(conn.req_headers, "authorizer", 0)

    case Phoenix.Token.verify(CrudWeb.Endpoint, @signing_salt, token) do
      {:ok, decoded} ->
        assign(conn, :user, decoded)

      {:error, error_type} ->
        conn
        |> put_status(401)
        |> json(%{
          "error_type" => error_type,
          "message" => "Erro ao autenticar"
        })
    end
  end
end
