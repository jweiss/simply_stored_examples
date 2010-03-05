require 'rubygems'
require 'simply_stored/couch'
require 'rocking_chair'

RockingChair.enable
RockingChair.enable_debug

require "helper"

class User
  include SimplyStored::Couch

  property :login
  property :email
  property :accepted_terms_of_service, :type => :boolean
  property :last_login, :type => Time
  has_many :posts
end

class Post
  include SimplyStored::Couch
  
  property :title
  belongs_to :user
end

bert = User.new(:login => 'bert', 
                :email => "bert@example.com",
                :last_login => Time.now)
                
bert.accepted_terms_of_service = true
bert.save!

puts "I just saved bert and his ID is #{bert.id}"
puts "His email is #{bert.reload.email}"

puts "Did bert accept the terms?"

puts "Yes he did" if bert.accepted_terms_of_service

Post.create!(:title => 'A nice post', :user => bert)

puts "Bert has #{bert.posts.size} posts"