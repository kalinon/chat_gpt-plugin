class CorsHandler < Kemal::Handler
  def call(env)
    process_cors(env)
    call_next(env)
  end

  def process_cors(env)
    env.response.headers.add("Access-Control-Allow-Origin", "https://chat.openai.com")
  end
end

static_headers do |response, filepath, filestat|
  response.headers.add("Access-Control-Allow-Origin", "https://chat.openai.com")
  response.headers.add("Content-Size", filestat.size.to_s)
end
