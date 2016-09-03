defmodule Fantasygame.PageController do
  use Fantasygame.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
