defmodule ProtobufExp.Repo do
  use Ecto.Repo,
    otp_app: :protobuf_exp,
    adapter: Ecto.Adapters.Postgres
end
