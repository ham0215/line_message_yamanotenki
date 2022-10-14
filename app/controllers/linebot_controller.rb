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
          next unless event.message['text'] =~ /天気/

          yama = Yama.find_by_message(event.message['text'])
          Rails.logger.info(yama)
          if yama
            reply_text = "#{yama.name}の天気\n#{yama.url}"
            Rails.logger.info(reply_text)
            message = {
              type: 'text',
              text: reply_text
            }
            client.reply_message(event['replyToken'], message)
          end
        end
      end
    end
  end
end
