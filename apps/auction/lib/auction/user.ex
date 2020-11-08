defmodule Auction.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:user_name, :string)
    field(:email_address, :string)
    field(:password, :string, virtual: true)
    field(:hashed_password, :string)
    has_many(:bids, Auction.Bid)
    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:user_name, :email_address])
    |> validate_required([:user_name, :email_address, :hashed_password])
    |> validate_length(:user_name, min: 3)
    |> unique_constraint(:user_name)
  end

  def changeset_with_password(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, required: true)
    |> hash_password()
    |> changeset(attrs)
  end

  defp hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:hashed_password, Auction.Password.hash(password))
  end

  defp hash_password(changeset), do: changeset
end
