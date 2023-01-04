# frozen_string_literal: true

require 'application_system_test_case'

class SignUpTest < ApplicationSystemTestCase
  test 'sign up' do
    visit root_path
    assert_css 'h2', text: 'ログイン'
    click_link 'アカウント登録'

    # バリデーションエラーを発生させる
    click_button 'アカウント登録'
    assert_text '2 件のエラーが発生したため ユーザー は保存されませんでした。'

    fill_in 'Eメール', with: 'bob@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button 'アカウント登録'
    assert_text 'アカウント登録が完了しました。'
    assert_text 'bob@example.com としてログイン中'
    assert_css 'h1', text: 'Welcome!'
  end
end
