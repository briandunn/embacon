require 'rack/jsonp'
require 'embacon'
use Rack::JSONP
run Embacon.new
