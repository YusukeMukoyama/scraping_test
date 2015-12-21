# encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'csv'

CSV.open("list.csv", "w") do |csv|
  for path in 100000..100100 do 
    url = "http://store.lawson.co.jp/store/#{path}/"
    begin
      _html = open(url)
    rescue OpenURI::HTTPError
      sleep 1
      next
    end
    doc = Nokogiri::HTML(_html)

    shop =  doc.css('h3#pr_store').inner_text
    address = doc.css('td#pr_address').inner_text
    csv << [shop, address]
    sleep 1
  end
end
