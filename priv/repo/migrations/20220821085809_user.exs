defmodule Crud.Repo.Migrations.User do
  use Ecto.Migration

  def up do
    create table("users") do
      add :age, :integer
      add :username, :string
      add :password, :string

      timestamps()
    end
  end

  def down do
    drop table("users")
  end
end
