defmodule FrixelIntranet.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FrixelIntranet.Chats` context.
  """

  @doc """
  Generate a intranet_conversation.
  """
  def intranet_conversation_fixture(attrs \\ %{}) do
    {:ok, intranet_conversation} =
      attrs
      |> Enum.into(%{
        conversation_status: :active,
        conversation_topic: "some conversation_topic",
        conversation_type: :public
      })
      |> FrixelIntranet.Chats.create_intranet_conversation()

    intranet_conversation
  end
end
