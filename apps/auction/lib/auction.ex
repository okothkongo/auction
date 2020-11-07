defmodule Auction do
  alias Auction.{Item, Password, Repo, User}

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

  def get_user(id), do: Repo.get!(User, id)
  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
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
end
