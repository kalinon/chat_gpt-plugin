require "kemal"
require "./open_api"
require "./handlers/*"

add_handler CorsHandler.new

get "/openapi.yaml" do |env|
  env.response.headers["Content-Type"] = "application/x-yaml"
  open_api.to_yaml
end

Kemal.run
