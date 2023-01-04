# frozen_string_literal: true

require 'application_system_test_case'

class CancelAccountTest < ApplicationSystemTestCase
  setup do
    sign_in_as_alice
  end

  test 'cancel account' do
    click_link 'Edit account'
    accept_alert do
      click_button 'Cancel my account'
    end
    assert_text 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
    assert_css 'h2', text: 'Log in'
  end
end
