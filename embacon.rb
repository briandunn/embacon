require 'nokogiri'
require 'open-uri'
class Embacon
  def call env
    [200, {'Content-Type' => 'json'}, [%<"#{fetch_bacon}">]]
  end
  private
  def fetch_bacon
    Nokogiri(URI.parse('http://baconipsum.com/?paras=1&type=all-meat').open.read).xpath("//div[@id='content']/div[1]/p/text()").to_s
  end
end
