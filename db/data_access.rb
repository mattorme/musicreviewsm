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
    results = run_sql("select * from users where id = '#{id}';")
    return results[0]
end

def find_review_by_id(id)
    results = run_sql("select * from reviews where id = #{id};")
    return results[0]
end