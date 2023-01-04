# frozen_string_literal: true

require 'application_system_test_case'

class EditAccountTest < ApplicationSystemTestCase
  setup do
    sign_in_as_alice
  end

  test 'edit account' do
    click_link 'Edit account'

    # test validation errors
    fill_in 'Email', with: ''
    click_button 'Update'
    assert_text '2 errors prohibited this user from being saved'

    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Current password', with: 'password'
    click_button 'Update'
    assert_text 'Your account has been updated successfully.'
    assert_text 'Account: bob@example.com'
    assert_css 'h1', text: 'Welcome!'
  end
end
