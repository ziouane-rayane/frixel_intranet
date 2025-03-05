defmodule FrixelIntranet.Chats.IntranetConversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intranet_conversations" do
    field :conversation_type, Ecto.Enum, values: [:public, :private]
    field :conversation_status, Ecto.Enum, values: [:active, :archived]
    field :conversation_topic, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intranet_conversation, attrs) do
    intranet_conversation
    |> cast(attrs, [:conversation_type, :conversation_status, :conversation_topic])
    |> validate_required([:conversation_type, :conversation_status, :conversation_topic])
  end
end
