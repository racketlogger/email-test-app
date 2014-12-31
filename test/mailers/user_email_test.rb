require 'test_helper'

class UserEmailTest < ActionMailer::TestCase
  test "user_activation" do
    mail = UserEmail.user_activation
    assert_equal "User activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
