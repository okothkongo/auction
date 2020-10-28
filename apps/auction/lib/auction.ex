defmodule Auction do
  alias Auction.Item
  @repo Auction.Repo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attr) do
    @repo.get_by(Item, attr)
  end

  def insert_item(attrs) do
    Item
    |> struct(attrs)
    |> @repo.insert()
  end

  def delete_item(%Auction.Item{} = item), do: @repo.delete(item)
end
