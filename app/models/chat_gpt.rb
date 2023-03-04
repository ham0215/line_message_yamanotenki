# frozen_string_literal: true

class ChatGpt
  def initialize
    @connection = Faraday.new(
      url: 'https://api.openai.com',
      headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{ENV.fetch('OPENAI_API_KEY', nil)}" }
    )
  end

  def request(msg)
    response = @connection.post('/v1/chat/completions') do |req|
      req.body = { model: 'gpt-3.5-turbo', messages: [{ role: 'user', content: msg }] }.to_json
    end

    JSON.parse(response.body).dig('choices', 0, 'message', 'content')
  rescue StandardError => e
    Rails.logger.error(e.inspect)
    nil
  end
end
