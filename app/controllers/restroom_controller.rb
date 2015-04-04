require 'open3'

class RestroomController < ApplicationController
  include HTTParty
  $RESTROOM_STATUS = "init"
  SERVER_ADDRESS = "http://172.20.10.4:3000/"
  def show
    @status = report_status
    puts @status
  end

  def status
    @status = report_status
    render json:{"id" => "2", "toilet_status" => @status } 
  end

  # worker interval settings in /schedule.rb
  def self.check_status
    current_status = report_status
    puts current_status
    unless current_status == $RESTROOM_STATUS
      send_status current_status 
      $RESTROOM_STATUS = current_status.to_s
    end
  end

 
  def self.report_status
    stdin, stdout, stderr, wait_thr = Open3.popen3("sudo python c.py ")
    distance = stdout.gets(nil)
    stdout.close
    begin
      if distance.to_f < 50
        return "full"
      else 
        return "empty"
      end
    rescue
      puts "ERROR OCCURRED -- distance : " + distance.to_s
      return "FAIL"
    end
  end

  def self.send_status current_status
    begin
      HTTParty.get( SERVER_ADDRESS + current_status.to_s + "/2")
    rescue
    end
  end
end
