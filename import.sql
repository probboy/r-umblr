CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50),
  firstname  VARCHAR(50),
  lastname VARCHAR(50),
  email VARCHAR(50),
  birthday timestamp,
  password VARCHAR(50),
  date_created timestamp DEFAULT current_timestamp
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  content VARCHAR(256),
  image_url VARCHAR(256),
  user_id VARCHAR(50),
  title VARCHAR(50),
  datetime timestamp DEFAULT current_timestamp,
  date_created timestamp DEFAULT current_timestamp
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  comments VARCHAR(256),
  date_created timestamp DEFAULT current_timestamp
);

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  tags VARCHAR(15),
  date_created timestamp DEFAULT current_timestamp
);

CREATE TABLE taggings (
  id SERIAL PRIMARY KEY,
  post_id INTEGER references posts(id) ON DELETE CASCADE,
  tag_id INTEGER references tags(id) ON DELETE CASCADE,
  date_created timestamp DEFAULT current_timestamp
);