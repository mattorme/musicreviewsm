CREATE DATABASE mr_sm;

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    username VARCHAR(30),
    title VARCHAR(100),
    artist_name VARCHAR(50), 
    content TEXT,
    score INTEGER,
    spotify_embed TEXT,
    album_img TEXT, 
    likes INTEGER,
    posting_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    username VARCHAR(30),
    email TEXT,
    password_digest TEXT
);

ALTER TABLE users ADD COLUMN followers INTEGER;