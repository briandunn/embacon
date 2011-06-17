$:.unshift File.dirname __FILE__
require 'rack/jsonp'
require 'embacon'
use Rack::JSONP
run Embacon.new
