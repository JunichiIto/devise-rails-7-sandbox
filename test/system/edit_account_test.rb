# frozen_string_literal: true

require 'application_system_test_case'

class EditAccountTest < ApplicationSystemTestCase
  setup do
    sign_in_as_alice
  end

  test 'edit account' do
    click_link 'アカウント編集'

    # バリデーションエラーを発生させる
    fill_in 'Eメール', with: ''
    click_button '更新'
    assert_text 'エラーが発生したため ユーザー は保存されませんでした。'

    fill_in 'Eメール', with: 'bob@example.com'
    fill_in '現在のパスワード', with: 'password'
    click_button '更新'
    assert_text 'アカウント情報を変更しました。'
    assert_text 'bob@example.com としてログイン中'
    assert_css 'h1', text: 'Welcome!'
  end
end
