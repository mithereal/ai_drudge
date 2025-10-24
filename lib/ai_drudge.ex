defmodule AiDrudge do
  @moduledoc """
  AiDrudge keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def fetch_feed(url) do
    data =
      Req.get!(url)

    {data["title"], FastRSS.parse_rss(data.body)}
  end

  def parse_data(data) do
    Enum.map(data.items, fn x ->
      %{
        title: x["title"],
        description: x["description"],
        link: x["link"]
      }
    end)
  end

  def run(url) do
    {_title, feed} = fetch_feed(url)
    [h | _parsed] = parse_data(feed)

    AiDrudge.Agent.run(h.description)
  end
end
