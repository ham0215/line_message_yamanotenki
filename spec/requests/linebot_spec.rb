# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinebotController do
  describe 'POST /callback' do
    subject(:request) { post callback_path, headers:, params: }

    let(:headers) do
      {
        CONTENT_TYPE: 'application/json',
        Accept: 'application/json',
        HTTP_X_LINE_SIGNATURE: 'hoge'
      }
    end
    let(:line_client) { Line::Bot::Client.new }
    let(:params) do
      {
        events: [
          {
            type: 'message',
            replyToken: reply_token,
            message: { type: 'text', text: }
          }
        ]
      }.to_json
    end
    let(:reply_token) { 'replyTokenXXX' }

    before do
      allow(Line::Bot::Client).to receive(:new).and_return(line_client)
      allow(line_client).to receive(:validate_signature).and_return(true)
      allow(line_client).to receive(:reply_message)
    end

    context 'when accessed normally' do
      let(:text) { '古見岳の天気' }
      let(:reply_message) do
        {
          text: "古見岳の天気\nhttps://tenkura.n-kishou.co.jp/tk/kanko/kad.html?code=47150005&type=15&ba=hk",
          type: 'text'
        }
      end

      it 'successed' do
        request
        expect(response).to have_http_status(:ok)
        expect(line_client).to have_received(:reply_message).with(reply_token, reply_message).once
      end
    end

    context 'when multiple match' do
      let(:text) { '苗場山の天気' }
      let(:reply_message) do
        {
          text: "苗場山の天気\nhttps://tenkura.n-kishou.co.jp/tk/kanko/kad.html?code=15150015&type=15&ba=hk",
          type: 'text'
        }
      end

      it 'successed' do
        request
        expect(response).to have_http_status(:ok)
        expect(line_client).to have_received(:reply_message).with(reply_token, reply_message).once
      end
    end

    context 'when 登山部さん match', skip: 'Disabled ChatGPT' do
      let(:text) { '登山部さん調子はどうですか？' }
      let(:reply_message) do
        {
          text: '私は絶好調です',
          type: 'text'
        }
      end
      let(:chat_gpt_client) { ChatGpt.new }

      before do
        allow(ChatGpt).to receive(:new).and_return(chat_gpt_client)
        allow(chat_gpt_client).to receive(:request).and_return('私は絶好調です')
      end

      it 'successed' do
        request
        expect(response).to have_http_status(:ok)
        expect(line_client).to have_received(:reply_message).with(reply_token, reply_message).once
      end
    end
  end
end
