defmodule AiDrudgeWeb.PageController do
  use AiDrudgeWeb, :controller

  def home(conn, _params) do
    articles = AiDrudge.Articles.list_articles()

    render(conn, :home, articles: articles)
  end
end
