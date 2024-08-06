defmodule StoryWeaver.Repo do
  use Ecto.Repo,
    otp_app: :story_weaver,
    adapter: Ecto.Adapters.Postgres
end
