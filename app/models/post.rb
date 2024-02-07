class Post < ApplicationRecord
  has_one_attached :avatar
  validates :title, presence: true
end
