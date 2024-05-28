class Post < ActiveRecord::Base
  belongs_to :user

  # TODO: Copy-paste your code from previous exercise
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 5 }
  validates :url, format: { with: /\A(https?:\/\/|ftp:\/\/|file:\/\/)([^\/]*)(\/.*)?\Z/ }, presence: true
  validates :user, presence: true

  scope :latest, -> { order(date: :desc) }
  scope :top_posts, -> { order(votes: :desc) }
  scope :search_by_title, ->(title) { where("title like ?", "#{title}%") }
end
