module Api
  class ConversationsController < BaseController
    def index
      conversations = current_user.conversations.includes(:users, :messages)
      render json: conversations.map { |c| conversation_json(c) }
    end

    def create
      other_user = User.find(params[:user_id])

      if other_user.id == current_user.id
        return render json: { error: "You can't start a conversation with yourself" },
                      status: :unprocessable_entity
      end

      conversation = Conversation.between(current_user.id, other_user.id)
      conversation ||= Conversation.create!.tap do |c|
        c.users << [ current_user, other_user ]
      end

      render json: conversation_json(conversation), status: :ok
    end

    private

    def conversation_json(conversation)
      other_user = conversation.users.find { |u| u.id != current_user.id }
      last_message = conversation.messages.last

      {
        id: conversation.id,
        other_user: { id: other_user.id, username: other_user.username },
        last_message: last_message&.body,
        updated_at: conversation.updated_at
      }
    end
  end
end
