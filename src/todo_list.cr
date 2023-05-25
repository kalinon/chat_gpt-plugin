TODOS = Hash(UUID, Array(String)).new

post "/todos" do |env|
  user_id, convo_id = ChatGptHandler.parse_headers(env)
  unless TODOS[user_id]?
    TODOS[user_id] = [] of String
  end
  item = env.params.json["todo"].as(String)
  TODOS[user_id] << item
end

get "/todos" do |env|
  user_id, convo_id = ChatGptHandler.parse_headers(env)
  unless TODOS[user_id]?
    TODOS[user_id] = [] of String
  end
  env.response.content_type = "application/json"
  TODOS[user_id].to_json
end

delete "/todos" do |env|
  user_id, convo_id = ChatGptHandler.parse_headers(env)
  if TODOS[user_id].nil?
    TODOS[user_id] = [] of String
  end
  item = env.params.json["todo_idx"].as(Int64)
  TODOS[user_id].delete(item)
end
