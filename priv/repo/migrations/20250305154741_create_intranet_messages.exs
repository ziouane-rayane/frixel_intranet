defmodule FrixelIntranet.Repo.Migrations.CreateIntranetMessages do
  use Ecto.Migration

  def change do
    create table(:intranet_messages) do
      add :message_body, :string

      timestamps(type: :utc_datetime)
    end
  end
end
