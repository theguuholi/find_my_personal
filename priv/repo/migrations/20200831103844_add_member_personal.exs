defmodule FindMyPersonal.Repo.Migrations.AddMemberPersonal do
  use Ecto.Migration

  def change do
    alter table(:members) do
      add :avatar_url, :string
      add :teacher_id, references(:teacher, on_delete: :delete_all)
    end
  end
end
