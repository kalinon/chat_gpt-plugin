TODOS = Hash(String, Array(String)).new

post "/todos/:user" do |env|
  name = env.params.url["user"]
  unless TODOS[name]?
    TODOS[name] = [] of String
  end
  item = env.params.json["todo"].as(String)
  TODOS[name] << item
end

get "/todos/:user" do |env|
  name = env.params.url["user"]
  unless TODOS[name]?
    TODOS[name] = [] of String
  end
  env.response.content_type = "application/json"
  TODOS[name].to_json
end

delete "/todos/:user" do |env|
  name = env.params.url["user"]
  if TODOS[name].nil?
    TODOS[name] = [] of String
  end
  item = env.params.json["todo_idx"].as(Int64)
  TODOS[name].delete(item)
end
