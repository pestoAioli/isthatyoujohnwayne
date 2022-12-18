defmodule IsThatYouJohnWayne.ParagraphGenerator.Paragraph do
  use Ecto.Schema
  import Ecto.Changeset

  schema "paragraphs" do
    field :content, :string
    field :prompt, :string

    timestamps()
  end

  @doc false
  def changeset(paragraph, attrs) do
    paragraph
    |> cast(attrs, [:prompt, :content])
    |> validate_required([:prompt, :content])
  end
end
