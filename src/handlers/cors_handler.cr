class CorsHandler < Kemal::Handler
  def call(env)
    if env.request.method == "OPTIONS"
      send_options(env)
    else
      process_cors(env)
    end
    call_next(env)
  end

  def send_options(env)
    env.response.headers.add "Access-Control-Allow-Headers", "*"
    env.response.headers.add "Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, PATCH"
    env.response.headers.add "Access-Control-Allow-Origin", "*"
    env.response.headers.add "Access-Control-Max-Age", "7200"
    env.response.headers.add "Cache-Control", "public, max-age=7200"
  end

  def process_cors(env)
    env.response.headers.add("Access-Control-Allow-Origin", "https://chat.openai.com")
  end
end

static_headers do |response, filepath, filestat|
  response.headers.add("Access-Control-Allow-Headers", "*")
  response.headers.add("Access-Control-Allow-Origin", "https://chat.openai.com")
  response.headers.add("Content-Size", filestat.size.to_s)
end

options "/*" do
  # TODO: what should OPTIONS requests actually respond with?
  {msg: "ok"}.to_json
end
