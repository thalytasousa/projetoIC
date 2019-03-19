defmodule RumblWeb.PageController do
  use RumblWeb, :controller
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
