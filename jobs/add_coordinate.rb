i = 0
Yama.all.find_each do |y|
  puts i += 1
  q = { q: y.name }.to_query
  uri = URI("https://www.geocoding.jp/api/?#{q}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  req = Net::HTTP::Get.new(uri)
  res = http.request(req)
  x = Hash.from_xml(res.body)
  y.lat = x.dig("result", "coordinate", "lat").to_f
  y.lng = x.dig("result", "coordinate", "lng").to_f
  y.save!
end
