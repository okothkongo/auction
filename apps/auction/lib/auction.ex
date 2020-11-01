defmodule Auction do
  alias Auction.{Item, Repo}

  def list_items do
    Repo.all(Item)
  end

  def get_item(id) do
    Repo.get!(Item, id)
  end

  def get_item_by(attr) do
    Repo.get_by(Item, attr)
  end

  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def delete_item(id) do
    id
    |> get_item()
    |> Repo.delete()
  end

  def update_item(%Auction.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> Repo.update()
  end

  def new_item do
    Item.changeset(%Item{})
  end

  def edit_item(id) do
    get_item(id)
    |> Item.changeset()
  end
end
