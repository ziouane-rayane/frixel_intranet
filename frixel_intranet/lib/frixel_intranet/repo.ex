defmodule FrixelIntranet.Repo do
  use Ecto.Repo,
    otp_app: :frixel_intranet,
    adapter: Ecto.Adapters.Postgres
end
