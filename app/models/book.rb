class Book < ApplicationRecord


	belongs_to :user
	attachment :profile_image, destroy: false
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	scope :latest, -> {order(created_at: :desc)}
	scope :star, -> {order(evaluation: :desc)}

	def self.search(search, word)
		if search == "forward_match"
			@book = Book.where("title LIKE?", "#{word}")
		elsif search == "backward_match"
    	@book = Book.where("title LIKE?", "%#{word}")
		elsif search == "perfect_match"
			@book = Book.where("#{word}")
		elsif search == "partial_match"
			@book = Book.where("title LIKE?", "%#{word}%")
		end
	end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
