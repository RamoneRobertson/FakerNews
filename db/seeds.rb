require 'faker'
require 'rest-client'
require 'json'

User.delete_all
Post.delete_all

def create_dummy_data
  20.times do
    user = User.new(
      username: Faker::Internet.username(specifier: 8, separators: %w(. _ -)),
      email: Faker::Internet.email(domain: 'gmail.com')
    )
    user.save

    rand(1..5).times do
      response = RestClient.get("https://hacker-news.firebaseio.com/v0/topstories.json")
      post_ids = JSON.parse(response)
      id = post_ids.sample.to_s
      url = RestClient.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
      post_data = JSON.parse(url)
      post = Post.new(
        title: post_data["title"],
        url: post_data["url"],
        votes: post_data["score"],
        user: user,
        date: Faker::Date.between(from: 10.days.ago, to: Date.today),
        text: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
      )
      post.save
    end
  end
end

create_dummy_data
