defmodule FrixelIntranet.Repo.Migrations.CreateIntranetConversations do
  use Ecto.Migration

  def change do
    create table(:intranet_conversations) do
      add :conversation_type, :string
      add :conversation_status, :string
      add :conversation_topic, :string

      timestamps(type: :utc_datetime)
    end
  end
end
