require 'rubygems'
require 'simply_stored/couch'
require "helper"

class User
  include SimplyStored::Couch

  property :name
  property :email
  property :activated, :type => :boolean
end

bert      = User.create(:name => 'bert', :email => 'bert@example.com', :activated => true)
fake_bert = User.create(:name => 'bert', :email => 'bert@abc.com', :activated => false)
ernie     = User.create(:name => 'ernie', :email => 'ernie@example.com', :activated => true)

puts User.find(bert.id).name

puts User.find_by_name('bert').name

puts User.find_all_by_name('bert').map(&:name).inspect

puts User.find_all_by_name_and_activated('bert', true).size

puts User.find(:all, :limit => 1, :order => :desc).first.name