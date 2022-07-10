# frozen_string_literal: true

class Yama < ApplicationRecord
  self.inheritance_column = :_type_disabled

  class << self
    def find_by_message(message)
      all.find_each do |yama|
        return yama if message =~ /#{yama.name}/
      end
    end
  end

  def url
    "https://tenkura.n-kishou.co.jp/tk/kanko/kad.html?code=#{code}&type=#{type}&ba=hk"
  end
end
