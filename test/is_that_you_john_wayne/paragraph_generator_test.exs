defmodule IsThatYouJohnWayne.ParagraphGeneratorTest do
  use IsThatYouJohnWayne.DataCase

  alias IsThatYouJohnWayne.ParagraphGenerator

  describe "paragraphs" do
    alias IsThatYouJohnWayne.ParagraphGenerator.Paragraph

    import IsThatYouJohnWayne.ParagraphGeneratorFixtures

    @invalid_attrs %{content: nil, prompt: nil}

    test "list_paragraphs/0 returns all paragraphs" do
      paragraph = paragraph_fixture()
      assert ParagraphGenerator.list_paragraphs() == [paragraph]
    end

    test "get_paragraph!/1 returns the paragraph with given id" do
      paragraph = paragraph_fixture()
      assert ParagraphGenerator.get_paragraph!(paragraph.id) == paragraph
    end

    test "create_paragraph/1 with valid data creates a paragraph" do
      valid_attrs = %{content: "some content", prompt: "some prompt"}

      assert {:ok, %Paragraph{} = paragraph} = ParagraphGenerator.create_paragraph(valid_attrs)
      assert paragraph.content == "some content"
      assert paragraph.prompt == "some prompt"
    end

    test "create_paragraph/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ParagraphGenerator.create_paragraph(@invalid_attrs)
    end

    test "update_paragraph/2 with valid data updates the paragraph" do
      paragraph = paragraph_fixture()
      update_attrs = %{content: "some updated content", prompt: "some updated prompt"}

      assert {:ok, %Paragraph{} = paragraph} = ParagraphGenerator.update_paragraph(paragraph, update_attrs)
      assert paragraph.content == "some updated content"
      assert paragraph.prompt == "some updated prompt"
    end

    test "update_paragraph/2 with invalid data returns error changeset" do
      paragraph = paragraph_fixture()
      assert {:error, %Ecto.Changeset{}} = ParagraphGenerator.update_paragraph(paragraph, @invalid_attrs)
      assert paragraph == ParagraphGenerator.get_paragraph!(paragraph.id)
    end

    test "delete_paragraph/1 deletes the paragraph" do
      paragraph = paragraph_fixture()
      assert {:ok, %Paragraph{}} = ParagraphGenerator.delete_paragraph(paragraph)
      assert_raise Ecto.NoResultsError, fn -> ParagraphGenerator.get_paragraph!(paragraph.id) end
    end

    test "change_paragraph/1 returns a paragraph changeset" do
      paragraph = paragraph_fixture()
      assert %Ecto.Changeset{} = ParagraphGenerator.change_paragraph(paragraph)
    end
  end
end
