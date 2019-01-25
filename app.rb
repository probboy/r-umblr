require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "em/pure_ruby"

#require "em/pure_ruby"
# we must require our models file in order
#   to pull in the code from the models file
require_relative "models"
require_relative "helpers"
require "email_address"

enable :sessions

require "sinatra/base"
require "sinatra/flash"


get "/test" do
  erb :test
end

get "/" do
  @posts = Post.all
  erb :index
end

get "/logout" do
  user = User.find(session[:user_id])
  puts "Warren"
  puts user
  flash[:info] = "You have successfully logged out, #{user.firstname}."
  session[:user_id] = nil
  redirect "/"
end

post "/" do
  username = params[:username]
  password = params[:password]

  # session[:user_id] = nil
  @user = User.find_by(username: params[:username])
  if @user == ""
    flash[:warning] = "No such user found."
  elsif @user.password = password
    session[:user_id] = @user.id
    flash[:info] = "You have successfully logged in, #{@user.firstname}."
  elsif flash[:warning] = "Invalid username or password."
  end
  @posts = Post.all
  erb :index
end

post "/signup" do
  username = params[:username]
  email = params[:email]
  password = params[:password]
  reenter_password = params[:reenter_password]
  firstname = params[:firstname]
  lastname = params[:lastname]
  birthday = params[:birthday]

  if User.find_by(email: email.downcase)
    flash[:warning] = "That email is already taken."
    redirect "/"
  elsif !(EmailAddress.valid? email)
    flash[:warning] = "The email address you entered is not valid."
  elsif password != reenter_password
    flash[:warning] = "The email addresses you entered do not match."
  elsif User.create(
    username: username,
    email: email.downcase,
    password: password,
    firstname: firstname,
    lastname: lastname,
    birthday: birthday,
  )
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    flash[:info] = "You have successfully created your account, #{@user.firstname}."
  end
  erb :index
end

post "/posts" do
  title = params[:title]
  content = params[:content]
  image_url = params[:image_url]

  if /\.(png|jpg)\Z/.match(image_url)
    Post.create(
      title: title,
      content: params[:content],
      user_id: session[:user_id],
      image_url: params[:image_url],
      datetime: Time.now.utc,
    )
    flash[:info] = "You have successfully created your new post."
    @user = User.find(session[:user_id])
    redirect "/"
  else
    Post.create(
      title: title,
      content: params[:content],
      user_id: session[:user_id],
      image_url: "https://sandyjamesplanner.files.wordpress.com/2017/04/20111025-subway-trash.jpg",
      datetime: Time.now.utc,
    )
    flash[:info] = "You have successfully created your new post."
    @user = User.find(session[:user_id])
    redirect "/"
  end
end

get "/asc" do
  @posts = Post.order(datetime: :asc).limit(20)
  erb :index
end

get "/desc" do
  @posts = Post.order(datetime: :desc).limit(20)
  erb :index
end

get "/profile" do
  @user = User.find(session[:user_id])
  erb :profile
end

get "/destroy" do
  @user = User.find(session[:user_id])
  User.destroy(session[:user_id])
  flash[:info] = "You account has been deleted."
end
