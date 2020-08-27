defmodule FindMyPersonal.Members.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :birth_date, :date
    field :blood, :string
    field :email, :string
    field :height, :string
    field :name, :string
    field :weight, :string

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:name, :email, :birth_date, :blood, :height, :weight])
    |> validate_required([:name, :email, :birth_date, :blood, :height, :weight])
  end
end
