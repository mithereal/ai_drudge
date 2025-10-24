defmodule AiDrudge.FeedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AiDrudge.Feeds` context.
  """

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    {:ok, feed} =
      attrs
      |> Enum.into(%{
        active: true,
        host: "some host"
      })
      |> AiDrudge.Feeds.create_feed()

    feed
  end
end
