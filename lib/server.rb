require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require_relative './link'
require_relative './tag'
require_relative './user'
require_relative './data_mapper_setup'

enable :sessions
use Rack::Flash
use Rack::MethodOverride
set :sessions_secret, 'super secret'

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

get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  email = params[:email]
  password = params[:password]
  user = User.authenticate(email, password)

  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ['The email or password is incorrect']
    erb :'sessions/new'
  end
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
    # take messages from datamapper
    flash.now[:errors] = @user.errors.full_messages
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

delete '/sessions' do
  session[:user_id] = nil
  flash[:notice] = "Good bye!"
  redirect('/')
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end
