defmodule AiDrudge.Repo do
  use Ecto.Repo,
    otp_app: :ai_drudge,
    adapter: Ecto.Adapters.Postgres
end
