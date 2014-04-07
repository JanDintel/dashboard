class MessagesController < ApplicationController
  include ActionController::Live

  def create
    content = params[:message][:content]

    if content.present?
      redis.pipelined do
        redis.lpush 'messages', content
        redis.publish 'messages.create', content
      end
    end

    respond_to :js
  end

  def index
    @messages = redis.lrange 'messages', -100, 100
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"

    redis.subscribe('messages.create') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

  private

  def redis
    Redis.new
  end
end
