defmodule IsThatYouJohnWayneWeb.PageController do
  use IsThatYouJohnWayneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
