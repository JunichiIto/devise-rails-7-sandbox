# frozen_string_literal: true

require 'application_system_test_case'

class SignInOutTest < ApplicationSystemTestCase
  test 'sign in and sign out' do
    visit root_path
    assert_css 'h2', text: 'Log in'

    # test validation errors
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'foobar'
    click_button 'Log in'
    assert_text 'Invalid Email or password.'

    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    assert_text 'Signed in successfully.'
    assert_css 'h1', text: 'Welcome!'

    click_button 'Sign out'
    assert_text 'Signed out successfully.'
    assert_css 'h2', text: 'Log in'
  end

  test 'sign out via link' do
    visit root_path
    assert_css 'h2', text: 'Log in'

    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    assert_text 'Signed in successfully.'
    assert_css 'h1', text: 'Welcome!'

    click_link 'Sign out'
    assert_text 'Signed out successfully.'
    assert_css 'h2', text: 'Log in'
  end
end
