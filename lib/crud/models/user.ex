defmodule Crud.Models.User do
  use Ecto.Schema
  alias Crud.Repo

  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :age, :username, :password]}
  schema "users" do
    field :age, :integer
    field :username, :string
    field :password, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:age, :username, :password])
    |> validate_required([:age, :username, :password])
  end

  def get_all(), do: Repo.all(Crud.Models.User)

  def find_by_id(id), do: Repo.get(Crud.Models.User, id)

  def find_by_username(username) do
    case Repo.get_by(Crud.Models.User, username: username) do
      user when user != nil -> {:ok, user}
      _ -> {:error, "Failed to try get user by username"}
    end
  end

  def insert(user) do
    %Crud.Models.User{}
    |> changeset(user)
    |> Repo.insert()
  end

  def update(id, data) do
    case find_by_id(id) do
      nil ->
        {:error, :not_found}

      user ->
        user
        |> changeset(data)
        |> Repo.update()
    end
  end

  def delete(id) do
    case find_by_id(id) do
      nil ->
        {:error, :not_found}

      user ->
        Repo.delete(user)
    end
  end
end
