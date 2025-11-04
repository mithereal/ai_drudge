defmodule AiDrudge.Kaffy.Config do
  @moduledoc """
  General configuration for Kaffy.
  """

  def create_resources(_conn) do
    [
      Feeds: [
        resources: [
          feeds: [schema: AiDrudge.Feeds.Feed, admin: AiDrudge.Kaffy.Feed]
        ]
      ],
      Articles: [
        resources: [
          articles: [schema: AiDrudge.Articles.Article, admin: AiDrudge.Kaffy.Article]
        ]
      ],
      scheduled_tasks: [
        AiDrudge.Kaffy.Tasks
      ]
    ]
  end
end
