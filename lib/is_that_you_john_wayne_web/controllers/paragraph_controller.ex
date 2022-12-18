defmodule IsThatYouJohnWayneWeb.ParagraphController do
  use IsThatYouJohnWayneWeb, :controller

  alias IsThatYouJohnWayne.ParagraphGenerator
  alias IsThatYouJohnWayne.ParagraphGenerator.Paragraph

  def index(conn, _params) do
    paragraphs = ParagraphGenerator.list_paragraphs()
    render(conn, "index.html", paragraphs: paragraphs)
  end

  def new(conn, _params) do
    changeset = ParagraphGenerator.change_paragraph(%Paragraph{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"paragraph" => paragraph_params}) do
    case ParagraphGenerator.create_paragraph(paragraph_params) do
      {:ok, paragraph} ->
        conn
        |> put_flash(:info, "Paragraph created successfully.")
        |> redirect(to: Routes.paragraph_path(conn, :show, paragraph))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    paragraph = ParagraphGenerator.get_paragraph!(id)
    render(conn, "show.html", paragraph: paragraph)
  end

  def edit(conn, %{"id" => id}) do
    paragraph = ParagraphGenerator.get_paragraph!(id)
    changeset = ParagraphGenerator.change_paragraph(paragraph)
    render(conn, "edit.html", paragraph: paragraph, changeset: changeset)
  end

  def update(conn, %{"id" => id, "paragraph" => paragraph_params}) do
    paragraph = ParagraphGenerator.get_paragraph!(id)

    case ParagraphGenerator.update_paragraph(paragraph, paragraph_params) do
      {:ok, paragraph} ->
        conn
        |> put_flash(:info, "Paragraph updated successfully.")
        |> redirect(to: Routes.paragraph_path(conn, :show, paragraph))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", paragraph: paragraph, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    paragraph = ParagraphGenerator.get_paragraph!(id)
    {:ok, _paragraph} = ParagraphGenerator.delete_paragraph(paragraph)

    conn
    |> put_flash(:info, "Paragraph deleted successfully.")
    |> redirect(to: Routes.paragraph_path(conn, :index))
  end
end
