require 'rubygems'
require 'simply_stored/couch'
require "helper"

class User
  include SimplyStored::Couch

  property :login
  property :email
  property :accepted_terms_of_service, :type => :boolean
  property :last_login, :type => Time
  
  validates_presence_of :login
  validates_inclusion_of :email, :in => %w(bert@example.com ernie@example.com)
  
  before_validation :check_last_login
  after_save :yell
  
  def check_last_login
    if last_login
      errors.add(:last_login, "is too old") if last_login < 1.day.ago
    end
  end
  
  def yell
    puts "YAY! #{id} was saved"
  end
end

ernie = User.new
ernie.last_login = 1.week.ago

if ernie.save
  puts "Ernie was saved!"
else
  puts "Ernie was not saved because: #{ernie.errors.inspect}"
end

ernie.login = 'ernie'
ernie.email = 'bert@example.com'
ernie.last_login = Time.now
ernie.save
