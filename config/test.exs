import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
env_db_user =
  System.get_env("POSTGRES_USER") ||
    raise """
    environment variable POSTGRES_USER is missing.
    """

env_db_passwd =
  System.get_env("POSTGRES_PASSWORD") ||
    raise """
    environment variable POSTGRES_PASSWORD is missing.
    """

env_db_hostname =
  System.get_env("POSTGRES_HOSTNAME") ||
    raise """
    environment variable POSTGRES_HOSTNAME is missing.
    Example: localhost
    """

env_db_dbname =
  System.get_env("POSTGRES_DBNAME") ||
    raise """
    environment variable POSTGRES_DBNAME is missing.
    Example: my_app_website_dev
    """

config :frixel_intranet, FrixelIntranet.Repo,
  username: env_db_user,
  password: env_db_passwd,
  database: env_db_dbname,
  hostname: env_db_hostname,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :frixel_intranet, FrixelIntranetWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "85Ri2rpUHJFnnEQB0a4XKPziBqEuIeIXGfqhfdFSO4yB9xyTZ5jNrJwG/29DG9Jh",
  server: false

# In test we don't send emails
config :frixel_intranet, FrixelIntranet.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
