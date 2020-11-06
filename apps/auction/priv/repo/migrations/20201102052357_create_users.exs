defmodule Auction.Repo.Migrations.CreateUsers do
  use Ecto.Migration

 def change do
  create table(:users) do
    add :user_name, :string
    add :email_address, :string
    add :hashed_password, :string
    timestamps()
  end
  create unique_index(:users, [:user_name])
 end
end
