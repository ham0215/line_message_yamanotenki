# frozen_string_literal: true

# rubocop:disable all
namespace :scraping do
  desc 'start scraping'
  task :start do
    require 'open-uri'
    require 'nokogiri'
    require 'json'

    urls = [
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=kk&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=hk&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=th&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=hr&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=tk&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=kn&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=cg&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=sk&type=15',
      'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=ks&type=15'
    ]
    re = /code=(\d+)&type=(\d+)/
    yamas = urls.each_with_object([]) do |url, array|
      doc = Nokogiri.HTML(URI.open(url).read)
      doc.css('a').each do |element|
        next unless element[:href] =~ /kad.html/

        re.match(element[:href])
        code = $1
        type = $2.to_i
        p code
        p type
        p element[:href]
        p element.children.text
        array << { code:, type:, name: element.children.text }
      end
    end
    File.open('app/models/yama.json', 'w') { JSON.dump({ yamas: }, _1) }
  end
end
# rubocop:enable all
