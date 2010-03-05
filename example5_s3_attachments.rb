require 'rubygems'
require 'simply_stored/couch'
require "helper"

class Log
  include SimplyStored::Couch

  property :status
  has_s3_attachment :data, :bucket => 'rugb-logs',
                           :access_key => File.read('aws_access_key'),
                           :secret_access_key => File.read('aws_secret_key'),
                           :location => :eu,
                           :after_delete => :delete,
                           :logger => Logger.new('/dev/null')
end

log = Log.new(:status => 0)
log.data = File.read('/var/log/system.log')
log.save

puts
puts "I just updloaded a #{log.data_size} bytes log to #{log.data_url}"