require 'rubygems'
require 'simply_stored/couch'
require "rocking_chair"

RockingChair.enable
RockingChair.enable_debug

require "helper"


class Post
  include SimplyStored::Couch

  property :title
  has_many :comments, :dependent => :destroy
end

class Comment
  include SimplyStored::Couch

  property :body
  belongs_to :post
end

puts "There are #{Comment.count} comments"

post = Post.create(:title => 'My first post')

5.times do |i|
  Comment.create(:post => post, :body => "Comment #{i}")
end

puts "The post has #{post.comment_count} comments, the first being #{post.comments(:order => :desc).first.body.inspect}"
puts "We can also only #{post.comments(:limit => 3, :order => :asc).size} comments"

first_comment = Comment.first

puts "The first comments belongs to #{first_comment.post.title.inspect}"

post.destroy

puts "There are #{Comment.count} comments"