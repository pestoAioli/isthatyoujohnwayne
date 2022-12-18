defmodule IsThatYouJohnWayne.ParagraphGeneratorFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IsThatYouJohnWayne.ParagraphGenerator` context.
  """

  @doc """
  Generate a paragraph.
  """
  def paragraph_fixture(attrs \\ %{}) do
    {:ok, paragraph} =
      attrs
      |> Enum.into(%{
        content: "some content",
        prompt: "some prompt"
      })
      |> IsThatYouJohnWayne.ParagraphGenerator.create_paragraph()

    paragraph
  end
end
