defmodule SecureNotes.Repo do
  use Ecto.Repo,
    otp_app: :secure_notes,
    adapter: Ecto.Adapters.Postgres
end
