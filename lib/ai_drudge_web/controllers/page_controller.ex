defmodule AiDrudgeWeb.PageController do
  use AiDrudgeWeb, :controller

  def home(conn, _params) do
    articles = AiDrudge.Articles.list_articles()

    render(conn, :home, articles: articles)
  end

  def search(conn, %{"query" => query}) do
    Task.start(fn ->
      AiDrudge.Agent.request(query)
    end)
    Phoenix.Controller.redirect(conn, to: "/admin")
    end
end
