class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
      return
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          next unless event.message['text'] =~ /天気/

          if yama = Yama.find_by_message(event.message['text'])
            reply_text = "#{yama.name}の天気\n#{yama.url}"
            message = {
              type: 'text',
              text: reply_text
            }
            client.reply_message(event['replyToken'], message)
          end
        end
      end
    }

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end
end
