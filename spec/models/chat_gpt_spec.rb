# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatGpt, type: :model do
  describe '#request' do
    let(:connection) { class_double(Faraday) }
    let(:body) do
      {
        choices: [
          message: {
            content: '私は絶好調です'
          }
        ]
      }.to_json
    end
    let(:response) { Data.define(:body).new(body:) }

    before do
      allow(Faraday).to receive(:new).and_return(connection)
      Data.define(:body)
      allow(connection).to receive(:post).and_return(response)
    end

    it 'return expected value' do
      expect(ChatGpt.new.request('hoge')).to eq '私は絶好調です'
    end
  end
end
