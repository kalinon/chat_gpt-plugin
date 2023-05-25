require "uuid"

class ChatGptHandler < Kemal::Handler
  USER_HEADER  = "openai-ephemeral-user-id"
  CONVO_HEADER = "openai-conversation-id"

  def call(env)
    if env.request.method == "OPTIONS"
      return call_next(env)
    end

    if env.request.headers[USER_HEADER]? && env.request.headers[CONVO_HEADER]?
      return call_next(env)
    end

    env.response.status_code = 401
  end

  def self.parse_headers(env) : Tuple(UUID, UUID)
    user_id = env.request.headers[USER_HEADER]
    convo_id = env.request.headers[CONVO_HEADER]
    {UUID.new(user_id), UUID.new(convo_id)}
  end
end
