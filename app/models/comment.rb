class Comment < ApplicationRecord
	belongs_to :user#, optional: true
	belongs_to :gossip#, optional: true
	belongs_to :commentable, polymorphic: true, optional: true
	has_many :comments, as: :commentable
	has_many :likes, as: :likeable
	validates :content, presence: true
end
