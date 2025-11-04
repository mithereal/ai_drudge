defmodule AiDrudge.Kaffy.Article do
  @moduledoc """
  Configuration for Articles in Kaffy admin.
  """

  alias AiDrudge.Articles

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Articles",
        content: "#{Articles.total_articles()}",
        icon: "user",
        order: 1,
        width: 3
      }
    ]
  end

  def index(_) do
    [
      id: nil,
      host: nil,
      name: nil,
      title: nil,
      description: nil,
      republican: nil,
      democrat: nil,
      support: nil
    ]
  end

  def form_fields(_) do
    [
      id: %{create: :hidden, update: :show},
      host: nil,
      name: nil,
      title: nil,
      description: nil,
      republican: nil,
      democrat: nil,
      support: nil
    ]
  end

  def insert(conn, _changeset) do
    host = conn.params["article"]["host"]
    name = conn.params["article"]["name"]
    title = conn.params["article"]["title"]
    description = conn.params["article"]["description"]
    republican = conn.params["article"]["republican"]
    democrat = conn.params["article"]["democrat"]
    support = conn.params["article"]["support"]

    attrs = %{
      "host" => host,
      "name" => name,
      "title" => title,
      "description" => description,
      "republican" => republican,
      "democrat" => democrat,
      "support" => support
    }

    Articles.create_article(attrs)
  end

  def delete(conn, _changeset) do
    with %{params: %{"ids" => id}} <- conn,
         {:ok, article} <- Articles.get_article(id),
         :ok = Articles.delete_article(article) do
      {:ok, article}
    else
      error ->
        {:error, error}
    end
  end

  def update(conn, changeset) do
    host = conn.params["article"]["host"]
    name = conn.params["article"]["name"]
    title = conn.params["article"]["title"]
    description = conn.params["article"]["description"]
    republican = conn.params["article"]["republican"]
    democrat = conn.params["article"]["democrat"]
    support = conn.params["article"]["support"]

    attrs = %{
      "host" => host,
      "name" => name,
      "title" => title,
      "description" => description,
      "republican" => republican,
      "democrat" => democrat,
      "support" => support
    }

    entry = Articles.Article.changeset(changeset, attrs) |> AiDrudge.Repo.update()
    {:ok, entry}
  end

  def custom_pages(_schema, _conn) do
    [
      %{
        slug: "ai-chat",
        name: "Ask Ai",
        view: AiDrudgeWeb.PageHTML,
        template: "ai_chat.html",
        assigns: [],
        order: 2
      }
    ]
  end
end
