class  LinebotManager
  require 'json'
  require 'line/bot'  # gem 'line-bot-api'

  # line developersに書いてあるChannel Access Token
  $access_token = "1/xQbeyCRj+Mx/CwFZfuPXruU4pa1OSjFyWK1bCed5SobbdOL6KVjubyWeZ0XHvquiJSKaMRe4XhzvL+OEpWQ+wxsjpi+i5kLFLPAQ+bsC0NN7gF8BwxN7/+x7hbTxwSYnKjeebmeY94Eyx6x6bjcwdB04t89/1O/w1cDnyilFU="
  $channel_secret = "ba33e412006c16f91e707e46a43642e6"
  # pushしたいときに送る先のuser_id or group_idを指定する
  $to = "U72798cffe98b02650a359df76ca76b36"
  # postされたログを残すスプレッドシートのid
  $spreadsheet_id = "1f9kl4Rr6Cfyg6WSm6DV7e67Bn5xSMY76j_Y0f0i7-Jk"

  def self.client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end



  #指定のuser_idにpushをする
  def self.push(text)

    message = {
      type: 'text',
      text: text
    }

    client = Line::Bot::Client.new { |config|
        config.channel_secret = $channel_secret
        config.channel_token = $access_token
    }
    response = client.push_message($to, message)
    p response

    #return UrlFetchApp.fetch(url, options);
  end

  def self.test_push
    self.push("てすと")
  end
end