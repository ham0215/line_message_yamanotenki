require 'rails_helper'

RSpec.describe LinebotController, type: :request do
  describe 'POST /callback' do
    let(:headers) do
      {
        'CONTENT_TYPE': 'application/json',
        'Accept': 'application/json',
        'HTTP_X_LINE_SIGNATURE': 'hoge',
      }
    end
    let(:params) do
      {
        events: [
          {
            type: 'message',
            replyToken: reply_token,
            message: { type: 'text', text: "#{yama.name}の天気" }
          }
        ]
      }.to_json
    end
    let(:reply_token) { 'replyTokenXXX' }
    let(:reply_message) do
      {
        text: "#{yama.name}の天気\nhttps://tenkura.n-kishou.co.jp/tk/kanko/kad.html?code=#{yama.code}&type=#{yama.type}&ba=hk",
        type: 'text'
      }
    end
    let(:yama) { create(:yama) }

    subject(:req) { post callback_path, { headers: headers, params: params } }

    let(:line_client) { Line::Bot::Client.new }
    before do
      allow(Line::Bot::Client).to receive(:new).and_return(line_client)
      allow(line_client).to receive(:validate_signature).and_return(true)
    end

    context 'when accessed normally' do
      before do
        expect(line_client).to receive(:reply_message).with(reply_token, reply_message).once
      end

      it 'successed' do
        req
        expect(response).to have_http_status(200)
      end
    end
  end
end
