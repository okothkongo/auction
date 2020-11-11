defmodule AuctionWeb.ItemView do
  use AuctionWeb, :view

  def is_bid_still_open?(end_time) do
    date_diff = DateTime.diff(DateTime.utc_now(), end_time)

    if date_diff >= 0 do
      true
    end
  end
end
