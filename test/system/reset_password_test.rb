# frozen_string_literal: true

require 'application_system_test_case'

class ResetPasswordTest < ApplicationSystemTestCase
  test 'reset password' do
    visit root_path
    assert_css 'h2', text: 'Log in'
    click_link 'Forgot your password?'

    # test validation errors
    click_button 'Send me reset password instructions'
    assert_text '1 error prohibited this user from being saved'

    fill_in 'Email', with: 'alice@example.com'
    click_button 'Send me reset password instructions'
    assert_text 'You will receive an email with instructions on how to reset your password in a few minutes.'
    assert_css 'h2', text: 'Log in'

    mail = ActionMailer::Base.deliveries.last
    m = mail.body.encoded.match(%r{http://example.com/(?<path>[-\w_?/=]+)})
    visit m[:path]
    assert_css 'h2', text: 'Change your password'

    # test validation errors
    click_button 'Change my password'
    assert_text '1 error prohibited this user from being saved'

    fill_in 'New password', with: 'pass1234'
    fill_in 'Confirm new password', with: 'pass1234'
    click_button 'Change my password'
    assert_text 'Your password has been changed successfully.'
    assert_css 'h1', text: 'Welcome!'
  end
end
