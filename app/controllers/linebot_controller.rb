# frozen_string_literal: true

class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery except: [:callback]

  def callback
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    reply
    head :ok
  end

  private

  def body
    @body ||= request.body.read
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.line_channel_secret
      config.channel_token = Rails.application.credentials.line_channel_token
    end
  end

  def reply # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          Rails.logger.info(event.message['text'])

          reply_text = case event.message['text']
                       when /天気/
                         tenki(event.message['text'])
                       when /登山部さん/
                         chat(event.message['text'])
                       end

          reply_message(event['replyToken'], generate_message(reply_text)) if reply_text
        end
      end
    end
  end

  def tenki(msg)
    yama = Yama.find_by_message(msg)
    Rails.logger.info(yama)

    "#{yama.name}の天気\n#{yama.url}" if yama
  end

  def chat(msg)
    ChatGpt.new.request(msg)
  end

  def generate_message(reply_text)
    Rails.logger.info(reply_text)
    {
      type: 'text',
      text: reply_text
    }
  end

  def reply_message(token, msg)
    client.reply_message(token, msg)
  end
end
