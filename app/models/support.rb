class Support < ApplicationRecord
  validates :title, presence: true
	validates :body, presence: true, length: { maximum: 200 }
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  belongs_to :user
end
