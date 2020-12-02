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

def current_user
  find_user_by_id(session[:user_id])
end

get '/' do
  latest_reviews = latest_reviews_preview(8)
  popular_reviews = popular_reviews_preview(8)
  erb :index, locals: {latest_reviews: latest_reviews, popular_reviews: popular_reviews}
end

get '/signup' do
  erb :signup
end

post '/signup' do
  password_digest = BCrypt::Password.create(params["password"])
  run_sql("INSERT INTO users (email, username, password_digest, followers) VALUES ('#{params["email"]}', '#{params["username"]}', '#{password_digest}', 0);")
  redirect "/"
end

get '/login' do 
  erb :login
end

post '/login' do 
  user = find_user_by_username(params['username'])
  if BCrypt::Password.new(user['password_digest']) == params['password']
    session[:user_id] = user['id']
    redirect "/"
  else 
    erb :login
  end
end


delete '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/latest' do
  latest_reviews = latest_reviews_preview(50)
  erb :latest, locals: {latest_reviews: latest_reviews}
end

get '/popular' do 
  popular_reviews = popular_reviews_preview(50)
  erb :popular, locals: {popular_reviews: popular_reviews}
end

get '/reviews/:id' do 
  individual_review = find_review_by_id("#{params[:id]}")
  erb :reviews, locals: {individual_review: individual_review}
end