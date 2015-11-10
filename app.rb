require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'warden'


class User < ActiveRecord::Base
end 

helpers do
  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end
end 

@admin = false

#Index of Users
get "/admin" do
  @admin = true
  @users = User.order("created_at DESC")
  @title = "Welcome."
  erb :"user/index"
end 

#Create a new user via Admin
get "/admin/users/create" do
 @admin = true
 @title = "Create User"
 @user = User.new
 erb :"user/create"
end
post "/admin/users/create" do
 @user = User.create(params[:user])
 if @user.save
     flash[:success] = 'New user created!'
     redirect "/admin/users/#{@user.id}"
 else
   erb :"user/create"
 end
end 

#Show specifc user
get "/admin/users/:id" do
 @admin = true
 @user = User.find(params[:id])
 @title = @user.username
 erb :"user/view"
end 

