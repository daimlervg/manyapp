defmodule ManyappWeb.PageController do
  use ManyappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
