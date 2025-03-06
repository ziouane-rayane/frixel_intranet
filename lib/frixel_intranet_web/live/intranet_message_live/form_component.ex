defmodule FrixelIntranetWeb.IntranetMessageLive.FormComponent do
  use FrixelIntranetWeb, :live_component

  alias FrixelIntranet.Chat

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage intranet_message records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="intranet_message-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
      <.input
        field={@form[:intranet_conversation_id]}
        type="select"
        label="Select Conversation"
        options={Enum.map(@conversations, fn intranet_conversation -> {intranet_conversation.conversation_topic, intranet_conversation.id} end)}
      />
        <.input field={@form[:message_body]} type="text" label="Message body" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Intranet message</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end
  IO.inspect(@conversations, label: "Conversations")

  @impl true
  def update(%{intranet_message: intranet_message} = assigns, socket) do
    conversation_id = Map.get(assigns, :conversation_id, nil)

    changeset =
      intranet_message
      |> Map.put(:intranet_conversation_id, conversation_id)
      |> Chat.change_intranet_message()

    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn -> to_form(changeset) end)}
  end



  @impl true
  def handle_event("validate", %{"intranet_message" => intranet_message_params}, socket) do
    changeset = Chat.change_intranet_message(socket.assigns.intranet_message, intranet_message_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"intranet_message" => intranet_message_params}, socket) do
    save_intranet_message(socket, socket.assigns.action, intranet_message_params)
  end

  defp save_intranet_message(socket, :edit, intranet_message_params) do
    case Chat.update_intranet_message(socket.assigns.intranet_message, intranet_message_params) do
      {:ok, intranet_message} ->
        notify_parent({:saved, intranet_message})

        {:noreply,
         socket
         |> put_flash(:info, "Intranet message updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_intranet_message(socket, :new, intranet_message_params) do
    case Chat.create_intranet_message(intranet_message_params) do
      {:ok, intranet_message} ->
        notify_parent({:saved, intranet_message})

        {:noreply,
         socket
         |> put_flash(:info, "Intranet message created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
