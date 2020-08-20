class Admin::SalesController < ApplicationController

  def index
    puts "HELOOOOO", @sales
    @sales = Sale.all
  end

end
