defmodule CrudWeb.UserController do
  use CrudWeb, :controller

  def index(conn, _) do
    json(conn, Crud.Models.User.get_all())
  end

  def me(conn, _options) do
    userId = Map.get(conn.assigns.user, "id")

    user = Crud.Repo.get(Crud.Models.User, userId)

    json(conn, user)
  end
end
