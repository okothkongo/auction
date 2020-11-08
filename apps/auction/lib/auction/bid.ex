defmodule Auction.Bid do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Auction.Bid

  schema "bids" do
    field(:amount, :integer)
    belongs_to(:item, Auction.Item)
    belongs_to(:user, Auction.User)
    timestamps()
  end

  def changeset(bid, params \\ %{}) do
    bid
    |> cast(params, [:amount, :user_id, :item_id])
    |> validate_required([:amount, :user_id, :item_id])
    |> assoc_constraint(:item)
    |> assoc_constraint(:user)
  end

  def bids_for_specific_user_query(user) do
    from(b in Bid,
      where: b.user_id == ^user.id,
      order_by: [desc: :inserted_at],
      preload: :item,
      limit: 10
    )
  end
end
