defmodule FrixelIntranet.Chat.IntranetMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "intranet_messages" do
    field :message_body, :string
    belongs_to :intranet_conversation, FrixelIntranet.Chat.IntranetConversation
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(intranet_message, attrs) do
    intranet_message
    |> cast(attrs, [:message_body, :intranet_conversation_id])
    |> validate_required([:message_body, :intranet_conversation_id])
  end
end
