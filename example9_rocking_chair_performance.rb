require 'rubygems'
require 'simply_stored/couch'
require 'rocking_chair'
require "benchmark"
require "helper"

class User
  include SimplyStored::Couch

  property :login
  property :email
  property :accepted_terms_of_service, :type => :boolean
  property :last_login, :type => Time
  has_many :posts
end

COUNT = 100

User.find_by_login(""); puts "\n\n\n"

Benchmark.bm(7) do |x|
  x.report("Talking to CouchDB") do
    count = COUNT
    now = Time.now
    count.times do |i|
      User.create!(:login => "user #{i}", :email => "user#{i}@example.com", :accepted_terms_of_service => true, :last_login => now)
      print '.'; $stdout.flush
    end
    
    count.times do |i|
      User.find_by_login("user #{i}")
      print '.'; $stdout.flush
    end
  end
  
  RockingChair.enable
  CouchPotato.couchrest_database.server.create_db('rugb')
  
  x.report("Talking to RockingChair") do
    count = COUNT
    now = Time.now
    count.times do |i|
      User.create!(:login => "user #{i}", :email => "user#{i}@example.com", :accepted_terms_of_service => true, :last_login => now)
      print '.'; $stdout.flush
    end
    
    count.times do |i|
      User.find_by_login("user #{i}")
      print '.'; $stdout.flush
    end
  end
end

  