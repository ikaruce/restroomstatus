require 'open3'

class RestroomController < ApplicationController
  def show
    @status = report_status
    puts @status
  end

  def status
    @status = report_status
    render json:{"id" => "2", "toilet_status" => @status } 
  end

private 
  def report_status
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
end
