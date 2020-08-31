defmodule FindMyPersonalWeb.MemberController do
  use FindMyPersonalWeb, :controller

  alias FindMyPersonal.Members
  alias FindMyPersonal.Members.Member
  alias FindMyPersonal.Teachers

  def index(conn, _params) do
    members = Members.list_members()
    render(conn, "index.html", members: members)
  end

  def search(conn, %{"filter" => filter}) do
    members = Members.list_members(filter)
    render(conn, "index.html", members: members)
  end

  def new(conn, _params) do
    changeset = Members.change_member(%Member{})
    teachers = Teachers.list_all()
    render(conn, "new.html", changeset: changeset, teachers: teachers)
  end

  def create(conn, %{"member" => member_params}) do
    case Members.create_member(member_params) do
      {:ok, member} ->
        conn
        |> put_flash(:info, "Member created successfully.")
        |> redirect(to: Routes.member_path(conn, :show, member))

      {:error, %Ecto.Changeset{} = changeset} ->
        teachers = Teachers.list_all()
        render(conn, "new.html", changeset: changeset, teachers: teachers)
    end
  end

  def show(conn, %{"id" => id}) do
    member = Members.get_member!(id)
    render(conn, "show.html", member: member)
  end

  def edit(conn, %{"id" => id}) do
    member = Members.get_member!(id)
    changeset = Members.change_member(member)
    teachers = Teachers.list_all()

    render(conn, "edit.html", member: member, changeset: changeset, teachers: teachers)
  end

  def update(conn, %{"id" => id, "member" => member_params}) do
    member = Members.get_member!(id)

    case Members.update_member(member, member_params) do
      {:ok, member} ->
        conn
        |> put_flash(:info, "Member updated successfully.")
        |> redirect(to: Routes.member_path(conn, :show, member))

      {:error, %Ecto.Changeset{} = changeset} ->
        teachers = Teachers.list_all()
        render(conn, "edit.html", member: member, changeset: changeset, teachers: teachers)
    end
  end

  def delete(conn, %{"id" => id}) do
    member = Members.get_member!(id)
    {:ok, _member} = Members.delete_member(member)

    conn
    |> put_flash(:info, "Member deleted successfully.")
    |> redirect(to: Routes.member_path(conn, :index))
  end
end
