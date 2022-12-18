defmodule IsThatYouJohnWayne.Repo.Migrations.CreateParagraphs do
  use Ecto.Migration

  def change do
    create table(:paragraphs) do
      add :prompt, :string
      add :content, :text

      timestamps()
    end
  end
end
