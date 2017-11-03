require 'test_helper'

class UsersLoginTestTest < ActionDispatch::IntegrationTest
  test "invalid info" do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                        #  email_confirmation: "user@invalid",
                                         password: "asd",
                                         password_confirmation: "fdas"}}
    end
    assert_template 'users/new'
    assert_select "div#error_explanation"

  end

  test "valid info" do
    get new_user_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert flash[:success] = "Welcome to the clubhouse, Example User."
    assert is_logged_in?
  end
end
