$:.unshift File.dirname __FILE__
require 'rack/jsonp'
require 'embacon'
use Rack::JSONP
use Rack::Static, :urls => [ '/index.html', '/embacon.js' ]
run Embacon.new
