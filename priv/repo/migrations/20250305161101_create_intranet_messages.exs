defmodule FrixelIntranet.Repo.Migrations.CreateIntranetMessages do
  use Ecto.Migration

  def change do
    create table(:intranet_messages) do
      add :message_body, :string
      add :intranet_conversation_id, references(:intranet_conversations, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
