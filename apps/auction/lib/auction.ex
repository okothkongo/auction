defmodule Auction do
  alias Auction.{FakeRepo, Item}
  @repo FakeRepo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attr) do
    @repo.get_by(Item, attr)
  end
end
