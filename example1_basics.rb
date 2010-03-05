require 'rubygems'
require 'simply_stored/couch'
require "helper"

class User
  include SimplyStored::Couch

  property :login
  property :email
  property :accepted_terms_of_service, :type => :boolean
  property :last_login, :type => Time
  property :complex
end

bert = User.new(:login => 'bert', 
                :email => "bert@example.com",
                :last_login => Time.now)
                
bert.complex = {:a => 'b', :c => [1,2,3,4,5]}                
bert.accepted_terms_of_service = true
bert.save

puts "I just saved bert and his ID is #{bert.id}"

puts "Did bert accept the terms?"

puts "Yes he did" if bert.accepted_terms_of_service

puts User.find(bert.id).complex.inspect