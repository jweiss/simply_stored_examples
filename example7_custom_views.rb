require 'rubygems'
require 'simply_stored/couch'
require 'rocking_chair'

RockingChair.enable
RockingChair.enable_debug

require "helper"

class Project
  include SimplyStored::Couch

  property :title
  property :budget
  property :due_at, :type => Time
  property :completed, :type => :boolean
  
  view :by_title_and_budget, :key => [:title, :budget]
  view :completed, :key => :name, :conditions => 'doc.completed === true'
end


p1 = Project.create(:title => 'One', :budget => 1000, :due_at => 3.weeks.from_now, :completed => false)
p2 = Project.create(:title => 'One', :budget => 1000, :due_at => Time.now, :completed => true)

puts Project.find_all_by_title_and_budget('One', 1000).map(&:id).inspect

puts CouchPotato.database.view(Project.completed('One')).map(&:id).inspect