require 'open-uri'

urls = [
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=kk&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=hk&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=th&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=hr&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=tk&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=kn&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=cg&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=sk&type=15',
  'https://tenkura.n-kishou.co.jp/tk/kanko/kasel.html?ba=ks&type=15',
]
re = /code=(\d+)&type=(\d+)/
urls.each do |url|
  doc = Nokogiri.HTML(open(url))
  doc.css('a').each do |element|
    next unless element[:href] =~ /kad.html/

    re.match(element[:href])
    code = $1
    type = $2.to_i
    p code
    p type
    p element[:href]
    p element.children.text
    Yama.create!(name: element.children.text, code: code, type: type)
  end
end
