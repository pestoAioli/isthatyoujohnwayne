defmodule IsThatYouJohnWayne.Repo do
  use Ecto.Repo,
    otp_app: :is_that_you_john_wayne,
    adapter: Ecto.Adapters.Postgres
end
