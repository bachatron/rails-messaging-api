module Api
  class MessagesController < BaseController
    def index
      conversation = current_user.conversations.find(params[:conversation_id])
      messages = conversation.messages.includes(:user).order(:created_at)
      render json: messages.map { |m| message_json(m) }
    end

    def create
      conversation = current_user.conversations.find(params[:conversation_id])
      message = conversation.messages.build(message_params)
      message.user = current_user

      if message.save
        render json: message_json(message), status: :created
      else
        render json: { errors: message.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    private

    def message_params
      params.permit(:body, :image)
    end

    def message_json(message)
      {
        id: message.id,
        body: message.body,
        user_id: message.user_id,
        username: message.user.username,
        image_url: message.image.attached? ? url_for(message.image) : nil,
        created_at: message.created_at
      }
    end
  end
end
