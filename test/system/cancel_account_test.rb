# frozen_string_literal: true

require 'application_system_test_case'

class CancelAccountTest < ApplicationSystemTestCase
  setup do
    sign_in_as_alice
  end

  test 'cancel account' do
    click_link 'アカウント編集'
    accept_alert do
      click_button 'アカウント削除'
    end
    assert_text 'アカウントを削除しました。またのご利用をお待ちしております。'
    assert_css 'h2', text: 'ログイン'
  end
end
