# frozen_string_literal: true

class Yama
  attr_reader :code, :type, :name

  class << self
    def find_by_message(message)
      yamas = yama_rows.select { message =~ /#{_1['name']}/ }
      return if yamas.empty?

      yama = if yamas.size == 1
               yamas.first
             else
               # 一番文字数が多いものを返す
               yamas.max { |a, b| a['name'].length <=> b['name'].length }
             end

      new(yama)
    end

    private

    def yama_rows
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
