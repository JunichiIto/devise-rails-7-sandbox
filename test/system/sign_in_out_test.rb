# frozen_string_literal: true

require 'application_system_test_case'

class SignInOutTest < ApplicationSystemTestCase
  test 'sign in and sign out' do
    visit root_path
    assert_css 'h2', text: 'ログイン'

    # バリデーションエラーを発生させる
    fill_in 'Eメール', with: 'bob@example.com'
    fill_in 'パスワード', with: 'hogehoge'
    click_button 'ログイン'
    assert_text 'Eメールまたはパスワードが違います。'

    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
    assert_css 'h1', text: 'Welcome!'

    click_link 'ログアウト'
    assert_text 'ログアウトしました。'
    assert_css 'h2', text: 'ログイン'
  end
end
