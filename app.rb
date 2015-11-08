require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'warden'


class User < ActiveRecord::Base
end 