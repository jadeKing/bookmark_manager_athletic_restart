require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require_relative 'modals/link'
require_relative 'modals/tag'
require_relative 'modals/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/users'
require_relative 'controllers/flash'
require_relative 'controllers/application'

enable :sessions
use Rack::Flash
use Rack::MethodOverride
set :sessions_secret, 'super secret'
set :partial_template_engine, :erb
