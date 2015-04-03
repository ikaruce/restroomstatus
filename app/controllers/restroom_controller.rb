class RestroomController < ApplicationController
  def show
    @status = "4124cm"
    puts @status
  end

  def status
    @status = "4124"
    render json:{"id" => "2", "status" => @status } 
  end
end
