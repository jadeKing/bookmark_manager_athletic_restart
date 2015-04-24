require 'sinatra'
require 'data_mapper'
require 'rack-flash'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require_relative './link'
require_relative './tag'
require_relative './user'

enable :sessions
use Rack::Flash
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
  @user = User.new
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
  @user = User.create(email: params[:email],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash[:notice] = 'Sorry, your passwords do not match'
    erb :'users/new'
  end
end

post '/set-flash' do
  # set flash notice
  flash[:notice] = 'Thanks for signing up!'
  # get flash notice
  flash[:notice]
  # set flash entry for current request
  flash.now[:notice] = 'Thanks for signing up!'
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end
