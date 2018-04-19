require "application_system_test_case"

class HomepagesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url
    assert_selector "h1", text: "Go Chef"
  end
  test "login in" do
    users(:two).update(password: '123greetings')
    visit root_url
    click_link('Login')
    assert page.current_path, "users/sign_in"
    fill_in "Email", with: users(:two).email
    fill_in "Password", with: "123greetings"
    click_button "Log in"
    assert page.current_path, '/'
    assert_selector "h2", text: "Hello Gordon Ramsey, welcome to Go Chef!"
  end
end
