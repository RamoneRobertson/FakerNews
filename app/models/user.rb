class User < ActiveRecord::Base
  has_many :posts

  # TODO: Copy-paste your code from previous exercise
  validates :username, presence: true, uniqueness: true
  validates :email, format: { with: /\A.*@.*\.com\z/ }, presence: true
end
