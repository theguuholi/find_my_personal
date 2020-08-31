defmodule FindMyPersonalWeb.Api.MemberControllerTest do
  use FindMyPersonalWeb.ConnCase

  alias FindMyPersonal.Members
  alias FindMyPersonal.Members.Member
  import FindMyPersonal.MemberFixture

  def fixture(:member) do
    {:ok, member} = Members.create_member(valid_attrs())
    member
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all members", %{conn: conn} do
      conn = get(conn, Routes.api_member_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create member" do
    test "renders member when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_member_path(conn, :create), member: valid_attrs())
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_member_path(conn, :show, id))

      assert %{
               "birth_date" => "1992-12-01",
               "blood" => "AB-",
               "email" => "teste@teste",
               "height" => "100",
               "name" => "Teste ",
               "weight" => "100",
               "avatar_url" =>
                 "https://images.unsplash.com/photo-1540206276207-3af25c08abc4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_member_path(conn, :create), member: invalid_attrs())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update member" do
    setup [:create_member]

    test "renders member when data is valid", %{conn: conn, member: %Member{id: id} = member} do
      conn = put(conn, Routes.api_member_path(conn, :update, member), member: update_attrs())
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_member_path(conn, :show, id))

      assert %{
               "avatar_url" =>
                 "https://images.unsplash.com/photo-1540206276207-3af25c08abc4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80",
               "birth_date" => "1992-12-01",
               "blood" => "AB-",
               "email" => "update@teste",
               "height" => "100",
               "name" => "update ",
               "weight" => "100"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, member: member} do
      conn = put(conn, Routes.api_member_path(conn, :update, member), member: invalid_attrs())
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete member" do
    setup [:create_member]

    test "deletes chosen member", %{conn: conn, member: member} do
      conn = delete(conn, Routes.api_member_path(conn, :delete, member))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_member_path(conn, :show, member))
      end
    end
  end

  defp create_member(_) do
    member = fixture(:member)
    %{member: member}
  end
end
