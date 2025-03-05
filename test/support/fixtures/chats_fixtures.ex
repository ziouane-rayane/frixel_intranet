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

  @doc """
  Generate a intranet_message.
  """
  def intranet_message_fixture(attrs \\ %{}) do
    {:ok, intranet_message} =
      attrs
      |> Enum.into(%{
        message_body: "some message_body"
      })
      |> FrixelIntranet.Chats.create_intranet_message()

    intranet_message
  end
end
