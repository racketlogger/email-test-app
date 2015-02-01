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

  def positive_match_score(email_address, player_name, score)
    #email is being sent to player_1
    @player_1 = player_name.titleize
    @score = score
    @player_2 = "john".titleize
    attachments.inline['rl-logo.png'] = File.read('app/assets/images/rl-logo.png')
    mail to: email_address, subject: "Score Report"
  end

  def negative_match_score(email_address, player_name, score)
    #email is being sent to player_1
    @player_1 = player_name.titleize
    @score = score
    @player_2 = "john".titleize
    attachments.inline['rl-logo.png'] = File.read('app/assets/images/rl-logo.png')
    mail to: email_address, subject: "Score Report"
  end

end




