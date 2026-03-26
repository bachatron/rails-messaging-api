class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  has_one_attached :image

  validates :body, presence: true, unless: -> { image.attached? }
end
