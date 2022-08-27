# frozen_string_literal: true

class Yama
  attr_reader :code, :type, :name

  class << self
    def find_by_message(message)
      yama = yamas.find { message =~ /#{_1['name']}/ }
      yama ? new(yama) : nil
    end

    private

    def yamas
      json['yamas']
    end

    def json
      return @json if instance_variable_defined? :@json

      @json = JSON.parse(File.read(Rails.root.join('app', 'models', 'yama.json')))
    end
  end

  def initialize(yama)
    @code = yama['code']
    @type = yama['type']
    @name = yama['name']
  end

  def url
    "https://tenkura.n-kishou.co.jp/tk/kanko/kad.html?code=#{code}&type=#{type}&ba=hk"
  end
end
