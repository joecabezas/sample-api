class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many :vote, dependent: :destroy

  validates :content, presence: true
end
