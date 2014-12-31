class UserEmail < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_email.user_activation.subject
  #
  
  def activation(email_address)
    attachments.inline['rl-logo.png'] = File.read('app/assets/images/rl-logo.png')
    mail to: email_address, subject: "Confirm your Racket Logger account, John"
  end

  def password_reset(email_address)
    mail to: email_address, subject: "Reset your RacketLogger password"
  end


end




