require 'rubygems'
require 'simply_stored/couch'
require "helper"

class Document
  include SimplyStored::Couch

  property :title
  enable_soft_delete # will use :deleted_at attribute by default
end


doc = Document.create(:title => 'secret project info')
puts Document.count

doc.destroy

puts Document.count
puts Document.count(:with_deleted => true)

begin
  Document.find(doc.id)
  puts "Found the document!"
rescue SimplyStored::RecordNotFound
  puts "there is no document with Id #{doc.id}"
end


begin
  Document.find(doc.id, :with_deleted => true)
  puts "Found the document!"
rescue SimplyStored::RecordNotFound
  puts "there is no document with Id #{doc.id}"
end
