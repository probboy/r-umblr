require "sinatra"
require "sendgrid-ruby"
require "sinatra/flash"
require "em/pure_ruby"
#require "em/pure_ruby"
# we must require our models file in order
#   to pull in the code from the models file
require_relative "models"

require_relative "helpers"

get "/create" do
  erb :create
end

post "/create" do
  post = Post.create(
    post: params[:post],
  )
end

get "/" do
  erb :landing
end

post "/blogposts" do
  posts = Post.create(
    post: params[:post],
  )

  redirect :user
end

get "/blogposts" do
  posts = Post.all
  comments = Comment.all
  erb :users
end

get "/signup" do
  erb :signup
end

post "/signup" do
  user = User.create(
    username: params[:username],
    password: params[:password],
  )

  session[:user_id] = user.id

  post = Post.all
  redirect "/blogposts"
end

get "/signin" do
  erb :signin
end

post "/signin" do
  user = User.find_by(username: params[:username])

  if user && user.password == params[:password] && params[:password] != ""
    session[:user_id] = user.id
    flash[:info] = "You have been signed in"
    redirect "/blogposts"
  else
    flash[:error] = "There was a problem with your signin"
    redirect "/signup"
  end
end

get "/logout" do
  session[:user_id] = nil
  redirect "/"
end
