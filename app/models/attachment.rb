class Attachment < ApplicationRecord
	belongs_to :posts
	has_one_attached :image

    has_one_attached :thumbnail do |attached|
    attached.variant(resize: [300, 300])
  end
end
