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

INSERT INTO reviews (username, title, artist_name, content, score, spotify_embed, album_img, likes) VALUES ('firstTest', 'Test Review', 'Artist Name', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Distinctio consectetur ab, exercitationem fuga in minima expedita. Provident eos consectetur vitae qui nesciunt magni voluptate sed expedita aut iusto inventore ullam eaque soluta, dolore ipsum repellat! Error porro iure modi nostrum illum et ullam neque doloribus nulla impedit laudantium eveniet enim nam, corporis a, odit natus velit quos adipisci quasi, pariatur distinctio temporibus delectus asperiores? Maiores et rerum ipsam voluptates mollitia! Eligendi sapiente omnis explicabo similique quo autem eaque, maiores veniam, rem minus, nobis illum quibusdam alias quod iure neque. Enim libero ut doloremque saepe blanditiis velit assumenda. Voluptatibus, facere esse.', 9.5, 'https://open.spotify.com/embed/album/7e7t0MCrNDcJZsPwUKjmOc', 'https://media.pitchfork.com/photos/5f02968d8813ffa92664f131/1:1/w_600/Shoot%20for%20the%20Stars%20Aim%20for%20the%20Moon_Pop%20Smoke.jpg', 0);


INSERT INTO reviews (username, title, artist_name, content, score, spotify_embed, album_img, likes) VALUES ('another test', 'Test Review', 'Artist Name', 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Distinctio consectetur ab, exercitationem fuga in minima expedita. Provident eos consectetur vitae qui nesciunt magni voluptate sed expedita aut iusto inventore ullam eaque soluta, dolore ipsum repellat! Error porro iure modi nostrum illum et ullam neque doloribus nulla impedit laudantium eveniet enim nam, corporis a, odit natus velit quos adipisci quasi, pariatur distinctio temporibus delectus asperiores? Maiores et rerum ipsam voluptates mollitia! Eligendi sapiente omnis explicabo similique quo autem eaque, maiores veniam, rem minus, nobis illum quibusdam alias quod iure neque. Enim libero ut doloremque saepe blanditiis velit assumenda. Voluptatibus, facere esse.', 8.5, 'https://open.spotify.com/embed/album/4VFG1DOuTeDMBjBLZT7hCK', 'https://upload.wikimedia.org/wikipedia/en/0/01/Anderson-Park-Malibu-Cover-Billboard-650x650.jpg', 1);

