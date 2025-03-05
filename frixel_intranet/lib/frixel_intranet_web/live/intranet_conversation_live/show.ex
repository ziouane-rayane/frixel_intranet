defmodule FrixelIntranetWeb.IntranetConversationLive.Show do
  use FrixelIntranetWeb, :live_view

  alias FrixelIntranet.Chats

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:intranet_conversation, Chats.get_intranet_conversation!(id))}
  end

  defp page_title(:show), do: "Show Intranet conversation"
  defp page_title(:edit), do: "Edit Intranet conversation"
end
