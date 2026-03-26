class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :users, through: :conversation_participants
  has_many :messages, dependent: :destroy

  has_one_attached :image # for image messages — actually this goes on Message

  # Find existing conversation between two users
  def self.between(user1_id, user2_id)
    joins(:conversation_participants)
      .where(conversation_participants: { user_id: user1_id })
      .joins(:conversation_participants)
      .where(conversation_participants: { user_id: user2_id })
      .first
  end
end
