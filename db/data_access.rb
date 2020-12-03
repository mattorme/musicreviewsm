require 'pg'

def run_sql(sql, params = [])
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'mr_sm'})
    results = db.exec_params(sql, params)
    db.close
    return results
end

def latest_reviews_preview(num)
    run_sql("select * from reviews order by id desc limit #{num};")
end

def popular_reviews_preview(num)
    run_sql("select * from reviews order by likes desc limit #{num}")
end

def find_user_by_username(username)
    results = run_sql("select * from users where username = '#{username}';")
    return results[0]
end

def find_user_by_id(id)
    results = run_sql("select * from users where id = #{id};")
    return results[0]
end

def find_review_by_id(id)
    results = run_sql("select * from reviews where id = #{id};")
    return results[0]
end

def find_reviews_from_followed_users_by_user_id(user_id)
    run_sql("select reviews.*, users.username from reviews inner join users on users.id = reviews.user_id where reviews.user_id in (select following_id from followers where follower_id = #{user_id}) order by id desc;")
end

def follow_user(current_user_id, following_user_id)
    puts current_user_id
    # puts "bob"
    run_sql("INSERT INTO followers (follower_id, following_id) VALUES (#{current_user_id}, #{following_user_id});")
end

def find_following_list(user_id)
    run_sql("select following_id from followers where follower_id = #{user_id};")
end

def find_users_reviews(user_id)
   run_sql("select * from reviews where user_id = #{user_id} order by id desc;")
end

# select reviews.*, users.username from reviews inner join users on users.id = reviews.user_id;

# INSERT INTO followers(follower_id, following_id) VALUES (3,1);