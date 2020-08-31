defmodule FindMyPersonal.MembersTest do
  use FindMyPersonal.DataCase

  alias FindMyPersonal.Members
  import FindMyPersonal.MemberFixture

  describe "members" do
    alias FindMyPersonal.Members.Member

    test "list_members/0 returns all members" do
      member = member_fixture()
      assert Members.list_members() == [member]
    end

    test "count_members_teacher/1 using filters" do
      member = member_fixture()
      assert Members.count_members_teacher(member.teacher_id) == 1
    end

    test "list_members/1 using filters" do
      member_fixture()
      assert Members.list_members("fsdfsdfds") == []
    end

    test "get_member!/1 returns the member with given id" do
      member = member_fixture()
      assert Members.get_member!(member.id) == member
    end

    test "create_member/1 with valid data creates a member" do
      assert {:ok, %Member{} = member} = Members.create_member(valid_attrs())
      assert member.birth_date == ~D[1992-12-01]
    end

    test "create_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Members.create_member(invalid_attrs())
    end

    test "update_member/2 with valid data updates the member" do
      member = member_fixture()
      assert {:ok, %Member{} = member} = Members.update_member(member, update_attrs())
      assert member.birth_date == ~D[1992-12-01]
      assert member.email == "update@teste"
    end

    test "update_member/2 with invalid data returns error changeset" do
      member = member_fixture()
      assert {:error, %Ecto.Changeset{}} = Members.update_member(member, invalid_attrs())
      assert member == Members.get_member!(member.id)
    end

    test "delete_member/1 deletes the member" do
      member = member_fixture()
      assert {:ok, %Member{}} = Members.delete_member(member)
      assert_raise Ecto.NoResultsError, fn -> Members.get_member!(member.id) end
    end

    test "change_member/1 returns a member changeset" do
      member = member_fixture()
      assert %Ecto.Changeset{} = Members.change_member(member)
    end
  end
end
