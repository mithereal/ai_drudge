defmodule AiDrudge.Kaffy.Feed do
  @moduledoc """
  Configuration for Feeds in Kaffy admin.
  """

  alias AiDrudge.Feeds

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Feeds",
        content: "#{Feeds.total_feeds()}",
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
      active: nil
    ]
  end

  def form_fields(_) do
    [
      id: %{create: :hidden, update: :show},
      host: nil,
      is_active: %{
        choices: [true, false],
        type: :array
      }
    ]
  end

  def insert(conn, _changeset) do
    host = conn.params["feed"]["host"]
    active = conn.params["feed"]["is_active"]

    attrs = %{
      "host" => host,
      "active" => active
    }

    Feeds.create_feed(attrs)
  end

  def delete(conn, _changeset) do
    with %{params: %{"ids" => id}} <- conn,
         {:ok, feed} <- Feeds.get_feed(id),
         :ok = Feeds.delete_feed(feed) do
      {:ok, feed}
    else
      error ->
        {:error, error}
    end
  end

  def update(conn, changeset) do
    host = conn.params["feed"]["email"]
    active = conn.params["feed"]["is_active"]

    attrs = %{
      "host" => host,
      "active" => active
    }

    entry = Feeds.Feed.changeset(changeset, attrs) |> AiDrudge.Repo.update()
    {:ok, entry}
  end
end
