defmodule Manyapp.Repo do
  use Ecto.Repo,
    otp_app: :manyapp,
    adapter: Ecto.Adapters.Postgres
end
