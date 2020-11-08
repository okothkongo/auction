defmodule Auction do
  alias Auction.{Bid, Item, Password, Repo, User}

  def list_items do
    Repo.all(Item)
  end

  def get_item(id) do
    Repo.get!(Item, id)
  end

  def get_item_by(attr) do
    Repo.get_by(Item, attr)
  end

  def get_item_with_bids(id) do
    id
    |> get_item()
    |> Repo.preload(bids: [:user])
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

  def get_user(id), do: Repo.get!(User, id)
  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(attrs) do
    %User{}
    |> User.changeset_with_password(attrs)
    |> Repo.insert()
  end

  def get_user_by_user_name_and_password(user_name, password) do
    with user when not is_nil(user) <- Repo.get_by(User, %{user_name: user_name}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify()
    end
  end

  def new_bid, do: Bid.changeset(%Bid{})

  def insert_bid(attrs) do
    %Bid{}
    |> Bid.changeset(attrs)
    |> Repo.insert()
  end

  def get_bids_for_user(user) do
    user
    |> Bid.bids_for_specific_user_query()
    |> Repo.all()
  end
end
