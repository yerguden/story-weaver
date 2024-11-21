import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :story_weaver, StoryWeaver.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "story_weaver_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  port: 5432

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :story_weaver, StoryWeaverWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "MTFF0Xfes8kncRTiyJG7a2t8ScLjOiehfnujIToH/wcHyY7xFPp7b+9gBorxr1ar",
  server: false

# In test we don't send emails.
config :story_weaver, StoryWeaver.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
