class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  # association User
  belongs_to :user

end
