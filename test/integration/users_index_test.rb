
require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:taro)
    @non_admin = users(:jiro)
  end

  # 管理者としてのindexページ(ページネーション、削除リンク含む)
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.user_name
      unless user == @admin # userがadminの時だけは、削除リンクが表示されない(管理者が自分で自分を削除できないように設定したため)
        assert_select 'a[href=?]', user_path(user), text: '削除'
      end
    end
    # assert_difference 'User.count', -1 do
    #   delete user_path(@non_admin)
    # end
  end

  # 一般ユーザとしてのindexページ
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: '削除', count: 0
  end
end