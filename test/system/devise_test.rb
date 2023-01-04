# frozen_string_literal: true

require 'application_system_test_case'

class DeviseTest < ApplicationSystemTestCase
  test 'Devise functions' do
    # アカウント登録
    visit root_path
    assert_css 'h2', text: 'ログイン'
    click_link 'アカウント登録'

    # バリデーションエラーを発生させる
    click_button 'アカウント登録'
    assert_text '2 件のエラーが発生したため ユーザー は保存されませんでした。'

    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button 'アカウント登録'
    assert_text 'アカウント登録が完了しました。'
    assert_text 'alice@example.com としてログイン中'

    # ログアウトとログイン
    click_link 'ログアウト'
    assert_text 'ログアウトしました。'
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

    # アカウント編集
    click_link 'アカウント編集'

    # バリデーションエラーを発生させる
    fill_in 'Eメール', with: ''
    click_button '更新'
    assert_text 'エラーが発生したため ユーザー は保存されませんでした。'

    fill_in 'Eメール', with: 'alice-2@example.com'
    fill_in '現在のパスワード', with: 'password'
    click_button '更新'
    assert_text 'アカウント情報を変更しました。'
    assert_current_path root_path
    assert_text 'alice-2@example.com としてログイン中'

    # パスワードのリセット
    click_link 'ログアウト'
    assert_text 'ログアウトしました。'
    click_link 'パスワードを忘れましたか？'

    # バリデーションエラーを発生させる
    click_button 'パスワードの再設定方法を送信する'
    assert_text 'エラーが発生したため ユーザー は保存されませんでした。'

    fill_in 'Eメール', with: 'alice-2@example.com'
    click_button 'パスワードの再設定方法を送信する'
    assert_text 'パスワードの再設定について数分以内にメールでご連絡いたします。'

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

    # 退会する
    click_link 'アカウント編集'
    accept_alert do
      click_button 'アカウント削除'
    end
    assert_text 'アカウントを削除しました。またのご利用をお待ちしております。'
    assert_current_path new_user_session_path
  end
end
