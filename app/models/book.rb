class Book < ApplicationRecord


	belongs_to :user
	attachment :profile_image, destroy: false
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	scope :latest, -> {order(created_at: :desc)}
	scope :star, -> {order(evaluation: :desc)}

	def self.search(range, keyword)
		if range == "2"
			@book = Book.where("title LIKE?", "#{keyword}")
		elsif range == "3"
    	@book = Book.where("category LIKE?", "#{keyword}")
		end
	end


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
