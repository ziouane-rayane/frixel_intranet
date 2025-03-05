defmodule FrixelIntranetWeb.IntranetMessageLiveTest do
  use FrixelIntranetWeb.ConnCase

  import Phoenix.LiveViewTest
  import FrixelIntranet.ChatsFixtures

  @create_attrs %{message_body: "some message_body"}
  @update_attrs %{message_body: "some updated message_body"}
  @invalid_attrs %{message_body: nil}

  defp create_intranet_message(_) do
    intranet_message = intranet_message_fixture()
    %{intranet_message: intranet_message}
  end

  describe "Index" do
    setup [:create_intranet_message]

    test "lists all intranet_messages", %{conn: conn, intranet_message: intranet_message} do
      {:ok, _index_live, html} = live(conn, ~p"/intranet_messages")

      assert html =~ "Listing Intranet messages"
      assert html =~ intranet_message.message_body
    end

    test "saves new intranet_message", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/intranet_messages")

      assert index_live |> element("a", "New Intranet message") |> render_click() =~
               "New Intranet message"

      assert_patch(index_live, ~p"/intranet_messages/new")

      assert index_live
             |> form("#intranet_message-form", intranet_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#intranet_message-form", intranet_message: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/intranet_messages")

      html = render(index_live)
      assert html =~ "Intranet message created successfully"
      assert html =~ "some message_body"
    end

    test "updates intranet_message in listing", %{conn: conn, intranet_message: intranet_message} do
      {:ok, index_live, _html} = live(conn, ~p"/intranet_messages")

      assert index_live |> element("#intranet_messages-#{intranet_message.id} a", "Edit") |> render_click() =~
               "Edit Intranet message"

      assert_patch(index_live, ~p"/intranet_messages/#{intranet_message}/edit")

      assert index_live
             |> form("#intranet_message-form", intranet_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#intranet_message-form", intranet_message: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/intranet_messages")

      html = render(index_live)
      assert html =~ "Intranet message updated successfully"
      assert html =~ "some updated message_body"
    end

    test "deletes intranet_message in listing", %{conn: conn, intranet_message: intranet_message} do
      {:ok, index_live, _html} = live(conn, ~p"/intranet_messages")

      assert index_live |> element("#intranet_messages-#{intranet_message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#intranet_messages-#{intranet_message.id}")
    end
  end

  describe "Show" do
    setup [:create_intranet_message]

    test "displays intranet_message", %{conn: conn, intranet_message: intranet_message} do
      {:ok, _show_live, html} = live(conn, ~p"/intranet_messages/#{intranet_message}")

      assert html =~ "Show Intranet message"
      assert html =~ intranet_message.message_body
    end

    test "updates intranet_message within modal", %{conn: conn, intranet_message: intranet_message} do
      {:ok, show_live, _html} = live(conn, ~p"/intranet_messages/#{intranet_message}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Intranet message"

      assert_patch(show_live, ~p"/intranet_messages/#{intranet_message}/show/edit")

      assert show_live
             |> form("#intranet_message-form", intranet_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#intranet_message-form", intranet_message: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/intranet_messages/#{intranet_message}")

      html = render(show_live)
      assert html =~ "Intranet message updated successfully"
      assert html =~ "some updated message_body"
    end
  end
end
