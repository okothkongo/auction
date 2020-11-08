defmodule Auction.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :amount, :integer
      add :item_id, references(:items)
      add :user_id, references(:users)
      timestamps()
    end
    create index(:bids, [:item_id])
    create index(:bids, [:user_id])
    create index(:bids, [:item_id, :user_id])
  end
end
