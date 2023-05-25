require "open-api"

OPEN_API = Open::Api.new

def open_api : Open::Api
  OPEN_API
end

open_api.info.tap do |info|
  info.title = "Example Crystal Plugin"
  info.version = "v1"
end

open_api.servers << Open::Api::Server.new("http://localhost:3000")
