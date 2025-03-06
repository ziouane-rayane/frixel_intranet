defmodule FrixelIntranetWeb.IntranetMessageLive.Index do
  use FrixelIntranetWeb, :live_view

  alias FrixelIntranet.Chat
  alias FrixelIntranet.Chat.IntranetMessage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :intranet_messages, Chat.list_intranet_messages())
    }

  end

  @impl true
  def handle_params(params, _url, socket) do
    case params do
      %{"id" => id} ->
        intranet_message = Chat.get_intranet_message!(id)
        conversation_id = intranet_message.intranet_conversation_id

        {:noreply,
         socket
         |> assign(:intranet_message, intranet_message)
         |> assign(:conversation_id, conversation_id)
         |> assign(:page_title, "Edit Intranet Message")
         |> assign(:conversations, Chat.list_intranet_conversations())}

      _ ->
        {:noreply,
         socket
         |> assign(:intranet_message, %FrixelIntranet.Chat.IntranetMessage{})
         |> assign(:conversation_id, nil)
         |> assign(:page_title, "New Intranet Message")
         |> assign(:conversations, Chat.list_intranet_conversations())}
    end
  end


  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Intranet message")
    |> assign(:intranet_message, Chat.get_intranet_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    conversations = Chat.list_intranet_conversations()

    socket
    |> assign(:page_title, "New Intranet message")
    |> assign(:intranet_message, %IntranetMessage{})
    |> assign(:conversations, conversations)

  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Intranet messages")
    |> assign(:intranet_message, nil)
  end

  @impl true
  def handle_info({FrixelIntranetWeb.IntranetMessageLive.FormComponent, {:saved, intranet_message}}, socket) do
    {:noreply, stream_insert(socket, :intranet_messages, intranet_message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    intranet_message = Chat.get_intranet_message!(id)
    {:ok, _} = Chat.delete_intranet_message(intranet_message)

    {:noreply, stream_delete(socket, :intranet_messages, intranet_message)}
  end
end
