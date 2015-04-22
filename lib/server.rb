require 'sinatra'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require_relative './link'
require_relative './tag'
require_relative './user'

enable :sessions
set :sessions_secret, 'super secret'

DataMapper.finalize

DataMapper.auto_upgrade!

get '/' do
  @links = Link.all
  erb :index
end

get '/tags/:text' do
  tag = Tag.first(text: params[:text])
  @links = tag ? tag.links : []
  erb :index
end

get '/users/new' do
  erb :'users/new'
end

# new links form submission
post '/links' do
  url = params['url']
  title = params['title']
  tags = params['tags'].split(' ').map do |tag|
    Tag.first_or_create(text: tag)
  end
  Link.create(url: url, title: title, tags: tags)
  redirect to('/')
end

# new user form
post '/users' do
  user = User.create(email: params[:email],
                     password: params[:password])
  session[:user_id] = user.id
  redirect to('/')
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end
