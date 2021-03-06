# frozen_string_literal: true

require "test_helper"

class Devise::PwnedPassword::Test < ActiveSupport::TestCase
  test "should deny validation for a pwned password" do
    password = "password"
    user = User.create email: "example@example.org", password: password, password_confirmation: password
    assert_not user.valid?, "User with pwned password shoud not be valid."
  end

  test "should accept validation for a password not in the dataset" do
    # This test will be unavoidably flaky
    password = "fddkasnsdddghjt"
    user = User.create email: "example@example.org", password: password, password_confirmation: password
    assert user.valid?, "User with password not in the dataset should be valid."
  end

  test "should return a non-zero count for a pwned password" do
    password = "password"
    user = User.create email: "example@example.org", password: password, password_confirmation: password
    assert_not_equal user.pwned_count, 0, "User with pwned password should not have a zero count."
  end

  test "should return a count of zero for a password not in the dataset" do
    # This test will be unavoidably flaky
    password = "fddkasnsdddghjt"
    user = User.create email: "example@example.org", password: password, password_confirmation: password
    assert_equal user.pwned_count, 0, "User with password not in the dataset should have a zero count."
  end
end
