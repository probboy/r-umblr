# we need to require this in order for line 9 to work
require "sinatra/activerecord"
require "pg"

# uses sinatra/activerecord to set database
#   authentication
# this is the equivalent of using:
#   ActiveRecord::Base.establish_connection
set :database, "postgresql:rumblr"

configure :production do
  # this environment variable is auto generated/set by heroku
  #   check Settings > Reveal Config Vars on your heroku app admin panel
  set :database, ENV["DATABASE_URL"]
end

# creates the User model
#   double check you have a users table before creating
#   this model
class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :tags, through: :taggings
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

class Tag < ActiveRecord::Base
  has_many :posts, through: :taggings
end

class Tagging < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag
end
