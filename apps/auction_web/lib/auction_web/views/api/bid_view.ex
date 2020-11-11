defmodule AuctionWeb.Api.BidView do
  use AuctionWeb, :view

  def render("bid.json", %{bid: bid}) do
    %{
      type: "bid",
      id: bid.id,
      amount: bid.amount
    }
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, __MODULE__, "item_with_bids.json")}
  end

  def render("item_with_bids.json", %{item: item}) do
    %{
      type: "item",
      id: item.id,
      title: item.title,
      description: item.description,
      ends_at: item.ends_at,
      bids: render_many(item.bids, AuctionWeb.Api.BidView, "bid.json")
    }
  end

  def render("item_bid.json", %{bid: bid}) do
    %{
      type: "bid",
      id: bid.id,
      amount: bid.amount,
      user: render_one(bid.user, AuctionWeb.Api.UserView, "user.json")
    }
  end
end
