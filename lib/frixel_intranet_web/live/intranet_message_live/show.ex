defmodule FrixelIntranetWeb.IntranetMessageLive.Show do
  use FrixelIntranetWeb, :live_view

  alias FrixelIntranet.Chat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    intranet_message = Chat.get_intranet_message!(params["id"])
    conversation_id = intranet_message.intranet_conversation_id

    {:noreply,
     socket
     |> assign(:intranet_message, intranet_message)
     |> assign(:conversation_id, conversation_id)
     |> assign(:page_title, "Show Intranet Message")}
  end

  defp page_title(:show), do: "Show Intranet message"
  defp page_title(:edit), do: "Edit Intranet message"
end
