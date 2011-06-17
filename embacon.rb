require 'nokogiri'
require 'open-uri'
class Embacon
  def call env
    unless env["PATH_INFO"] == '/'
      [200, {'Content-Type' => 'json'}, [%<"#{fetch_bacon}">]]
    else
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
