require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require_relative 'db/data_access'
also_reload 'db/data_access' if development?

enable :sessions

def logged_in?()
  if session[:user_id]
    true
  else 
    false
  end
end

get '/' do
  erb :index
end





