defmodule FindMyPersonal.MemberFixture do
  alias FindMyPersonal.Members
  alias FindMyPersonal.Teachers

  def valid_attrs,
    do: %{
      "avatar_url" =>
        "https://images.unsplash.com/photo-1540206276207-3af25c08abc4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80",
      "birth_date" => "1992-12-01",
      "blood" => "AB-",
      "email" => "teste@teste",
      "height" => "100",
      "name" => "Teste ",
      "teacher_id" => get_teacher(),
      "weight" => "100"
    }

  def update_attrs,
    do: %{
      "avatar_url" =>
        "https://images.unsplash.com/photo-1540206276207-3af25c08abc4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80",
      "birth_date" => "1992-12-01",
      "blood" => "AB-",
      "email" => "update@teste",
      "height" => "100",
      "name" => "update ",
      "teacher_id" => get_teacher(),
      "weight" => "100"
    }

  def invalid_attrs,
    do: %{
      "avatar_url" => "",
      "birth_date" => "",
      "blood" => "",
      "email" => "",
      "height" => "",
      "name" => " ",
      "teacher_id" => get_teacher(),
      "weight" => ""
    }

  def member_fixture(attrs \\ %{}) do
    {:ok, member} =
      attrs
      |> Enum.into(valid_attrs())
      |> Members.create_member()

    member
  end

  def get_teacher() do
    {:ok, teacher} =
      %{
        avatar_url: "some avatar_url",
        birth_date: ~D[2010-04-17],
        class_type: "some class_type",
        education_level: "some education_level",
        name: "some name"
      }
      |> Teachers.create_teacher()

    teacher.id
  end
end
