require 'nokogiri'
require 'open-uri'
class Embacon
  def call env
    case env['PATH_INFO'] 
    when '/index.json'
      [200, {'Content-Type' => 'json'}, [%<"#{fetch_bacon}">]]
    when '/'
      [302, {'Location' => '/index.html', 'Content-Type' => 'text/plain'}, []]
    end
  end

  private

  def fetch_bacon
    Nokogiri(
      URI.parse('http://baconipsum.com/?paras=1&type=all-meat').open.read
    ).xpath("//div[@id='content']/div[1]/p/text()")
  end
end
