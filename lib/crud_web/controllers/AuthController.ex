defmodule CrudWeb.AuthController do
  use CrudWeb, :controller

  @signing_salt "secret_md5"

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- Crud.Models.User.find_by_username(username),
         true <- String.equivalent?(user.password, password),
         token <- Phoenix.Token.sign(CrudWeb.Endpoint, @signing_salt, %{"id" => user.id}) do
      conn |> json(%{"token" => token})
    else
      _ ->
        conn
        |> json(%{"error" => "username/password is invalid"})
    end
  end

  @spec register(Plug.Conn.t(), any) :: Plug.Conn.t()
  def register(conn, _) do
    case(Crud.Models.User.insert(conn.body_params)) do
      {:ok, user} -> json(conn, user)
      {:error, error} -> json(conn, error)
    end
  end
end
