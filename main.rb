require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require_relative 'db/data_access'
require 'pry'
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

def following?(user_id, follower_id)
  following = find_following_list(follower_id).values.flatten

  following.include? user_id
end

get '/' do
  latest_reviews = latest_reviews_preview(100)
  popular_reviews = popular_reviews_preview(8)
  if logged_in?
   followed_reviewers = find_reviews_from_followed_users_by_user_id(session[:user_id])
  else 
   followed_reviewers = nil
  end
  erb :index, locals: {latest_reviews: latest_reviews, popular_reviews: popular_reviews, followed_reviewers: followed_reviewers}
end

get '/signup' do
  erb :signup
end

post '/signup' do
  password_digest = BCrypt::Password.create(params["password"])
  run_sql("INSERT INTO users (email, username, password_digest) VALUES ('#{params["email"]}', '#{params["username"]}', '#{password_digest}');")
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

get '/new' do
  redirect '/login' unless logged_in?
  erb :post
end

post '/new' do 
  sql = "insert into reviews (title, artist_name, content, score, spotify_embed, album_img) values ('#{params["title"]}', '#{params["artist_name"]}', '#{params["content"]}', #{params["score"]}, '#{params["spotify_embed"]}', '#{params["album_img"]}');"
  run_sql(sql)
  redirect "/"
end


get '/users/:user_id' do
  following = logged_in? && following?(params[:user_id], session[:user_id])


  users_reviews = find_users_reviews("#{params[:user_id]}")
  user = find_user_by_id("#{params['user_id']}")

  erb :profile, locals: {users_reviews: users_reviews, user: user, following: following}
end

post '/follow_user' do 

  follow_user(session[:user_id], params['user_id'])
  redirect '/'

end

get '/explore' do
  latest_reviews = latest_reviews_preview(4)
  popular_reviews = popular_reviews_preview(4)

  erb :explore, locals: {latest_reviews: latest_reviews, popular_reviews: popular_reviews}
end

get '/search' do
  if params['q']
    sql = "select * from reviews where title like '%#{params['q']}%' or artist_name like '%#{params['q']}%' or content like '%#{params['q']}%' order by id desc limit 100;"
  # elsif params['sport']
  #   sql = "select * from gifs where sport = '#{params['sport']}' order by id desc limit 21;"
  # elsif params['athlete']
  #   sql = "select * from gifs where athlete = '#{params['athlete']}' order by id desc limit 21;"
  else
    redirect '/'
  end
  search_reviews = run_sql(sql)
  erb :search, locals: {search_reviews: search_reviews}
end

