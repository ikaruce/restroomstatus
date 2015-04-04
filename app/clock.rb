require './config/boot'
require './config/environment'

require 'clockwork'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(3.seconds, 'check_status.job') { RestroomController.check_status }
end