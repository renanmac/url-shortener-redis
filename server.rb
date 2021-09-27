# frozen_string_literal: true

require 'sinatra'
require 'faker'
require 'sinatra/json'
require 'sinatra/reloader'
require 'ohm'

require_relative 'link'
require_relative 'user'

# Configurations
Faker::Config.random = Random.new(5)
Ohm.redis = Redic.new('redis://url-shortner-redis:6379')

set :bind, '0.0.0.0'

# Parse requests

helpers do
  def json_params
    JSON.parse(request.body.read)
  rescue StandardError
    halt 422, 'Error'
  end
end

# ROUTES

get '/' do
  links = Link.all.to_a.map(&:attributes)
  json links
end

post '/links' do
  data = json_params
  data['user'] = User[data.delete('user_id').to_i]
  link = Link.create(data)

  json link.attributes
end

get '/links/search/:slug' do
  link = Link.find(slug: params['slug']).first

  link.increment(:views)

  json link.attributes
end

post '/users' do
  user = User.create(json_params)

  json user.attributes
end

post '/seed' do
  ini = Time.now

  User.all.to_a.size.times do |index|
    1_000.times do
      site = Link.create(
        slug: Faker::Alphanumeric.alphanumeric(number: 4),
        url: Faker::Internet.unique.url, user: User[index]
      )

      site.save

    rescue StandardError
      puts 'Slug already be taken'
      Link.create(
        slug: Faker::Alphanumeric.alphanumeric(number: 5),
        url: Faker::Internet.unique.url, user: User[index]
      )
      next
    end
  end

  json message: "Links added #{Time.now - ini}"
end
