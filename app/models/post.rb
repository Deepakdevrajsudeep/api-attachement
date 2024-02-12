  class Post < ApplicationRecord
    has_one_attached :avatar
    has_one_attached :thumbnail
    has_many :attachement
    validates :title, presence: true
  end
