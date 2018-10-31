Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'], callback_url: "http://application-test.tk/auth/twitter/callback"
  #http://127.0.0.1:3000/auth/twitter/callback
end