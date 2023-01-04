# frozen_string_literal: true

require 'application_system_test_case'

class ResetPasswordTest < ApplicationSystemTestCase
  test 'reset password' do
    visit root_path
    assert_css 'h2', text: 'ログイン'
    click_link 'パスワードを忘れましたか？'

    # バリデーションエラーを発生させる
    click_button 'パスワードの再設定方法を送信する'
    assert_text 'エラーが発生したため ユーザー は保存されませんでした。'

    fill_in 'Eメール', with: 'alice@example.com'
    click_button 'パスワードの再設定方法を送信する'
    assert_text 'パスワードの再設定について数分以内にメールでご連絡いたします。'
    assert_css 'h2', text: 'ログイン'

    mail = ActionMailer::Base.deliveries.last
    m = mail.body.encoded.match(%r{http://example.com/(?<path>[-\w_?/=]+)})
    visit m[:path]
    assert_css 'h2', text: 'パスワードを変更'

    # バリデーションエラーを発生させる
    click_button 'パスワードを変更する'
    assert_text 'エラーが発生したため ユーザー は保存されませんでした。'

    fill_in '新しいパスワード', with: 'pass1234'
    fill_in '確認用新しいパスワード', with: 'pass1234'
    click_button 'パスワードを変更する'
    assert_text 'パスワードが正しく変更されました。'
    assert_css 'h1', text: 'Welcome!'
  end
end
