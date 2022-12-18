defmodule IsThatYouJohnWayneWeb.ParagraphControllerTest do
  use IsThatYouJohnWayneWeb.ConnCase

  import IsThatYouJohnWayne.ParagraphGeneratorFixtures

  @create_attrs %{content: "some content", prompt: "some prompt"}
  @update_attrs %{content: "some updated content", prompt: "some updated prompt"}
  @invalid_attrs %{content: nil, prompt: nil}

  describe "index" do
    test "lists all paragraphs", %{conn: conn} do
      conn = get(conn, Routes.paragraph_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Paragraphs"
    end
  end

  describe "new paragraph" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.paragraph_path(conn, :new))
      assert html_response(conn, 200) =~ "New Paragraph"
    end
  end

  describe "create paragraph" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.paragraph_path(conn, :create), paragraph: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.paragraph_path(conn, :show, id)

      conn = get(conn, Routes.paragraph_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Paragraph"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.paragraph_path(conn, :create), paragraph: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Paragraph"
    end
  end

  describe "edit paragraph" do
    setup [:create_paragraph]

    test "renders form for editing chosen paragraph", %{conn: conn, paragraph: paragraph} do
      conn = get(conn, Routes.paragraph_path(conn, :edit, paragraph))
      assert html_response(conn, 200) =~ "Edit Paragraph"
    end
  end

  describe "update paragraph" do
    setup [:create_paragraph]

    test "redirects when data is valid", %{conn: conn, paragraph: paragraph} do
      conn = put(conn, Routes.paragraph_path(conn, :update, paragraph), paragraph: @update_attrs)
      assert redirected_to(conn) == Routes.paragraph_path(conn, :show, paragraph)

      conn = get(conn, Routes.paragraph_path(conn, :show, paragraph))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, paragraph: paragraph} do
      conn = put(conn, Routes.paragraph_path(conn, :update, paragraph), paragraph: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Paragraph"
    end
  end

  describe "delete paragraph" do
    setup [:create_paragraph]

    test "deletes chosen paragraph", %{conn: conn, paragraph: paragraph} do
      conn = delete(conn, Routes.paragraph_path(conn, :delete, paragraph))
      assert redirected_to(conn) == Routes.paragraph_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.paragraph_path(conn, :show, paragraph))
      end
    end
  end

  defp create_paragraph(_) do
    paragraph = paragraph_fixture()
    %{paragraph: paragraph}
  end
end
