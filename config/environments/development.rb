Email::Application.configure do
  config.action_mailer.default_url_options = { host: 'racketlogger.com' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = CONFIG[:email_0][:delivery_method].to_sym
  config.action_mailer.smtp_settings = {
    address: CONFIG[:email_0][:address],
    port: CONFIG[:email_0][:port],
    domain: CONFIG[:email_0][:domain],
    authentication: CONFIG[:email_0][:authentication],
    enable_starttls_auto: CONFIG[:email_0][:enable_starttls_auto],
    user_name: CONFIG[:email_0][:user_name],
    password: CONFIG[:email_0][:password]
  }

  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
