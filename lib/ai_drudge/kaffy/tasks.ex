defmodule AiDrudge.Kaffy.Tasks do
  def task_query_feeds do
    [
      %{
        name: "Query Feeds",
        initial_value: nil,
        every: 150_000,
        action: fn _v ->
          AiDrudge.Feeds.cache_feeds()
          {:ok, nil}
        end
      }
    ]
  end
end
