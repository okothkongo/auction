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
    |> bid_not_less_than_smallest_bid()
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

  def bid_with_least_amount_query(item_id) do
    specific_bids_for_item = bids_for_specific_item_query(item_id)
    from(b in specific_bids_for_item, select: min(b.amount))
  end

  defp bids_for_specific_item_query(item_id) do
    from(b in Bid, where: b.item_id == ^item_id)
  end

  defp bid_not_less_than_smallest_bid(
         %Ecto.Changeset{changes: %{amount: amount, item_id: item_id}} = changeset
       ) do
    least_amount_bidded = Auction.least_amount_bidded(item_id)

    if amount > least_amount_bidded do
      changeset
    else
      add_error(changeset, :amount, "Kindly bid higher people have done much better")
    end
  end

  defp bid_not_less_than_smallest_bid(changeset) do
    changeset
  end
end
