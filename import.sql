CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(50),
  date_created timestamp DEFAULT current_timestamp
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  post VARCHAR(256),
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