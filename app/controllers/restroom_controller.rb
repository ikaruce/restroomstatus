class RestroomController < ApplicationController
  def show
    @status = "4124cm"
    puts @status
  end

  def status
    @status = report_status
    render json:{"id" => "2", "status" => @status } 
  end

private 
  def report_status
    distance = system("sudo python c.py")
    begin
      if distance.to_f < 50
        return "full"
      else 
        return "empty"
    rescue
      puts "ERROR OCCURRED -- distance : " + distance
      return "FAIL"
    end
  end 
end
