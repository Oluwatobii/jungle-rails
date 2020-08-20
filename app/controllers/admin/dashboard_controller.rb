class Admin::DashboardController < ApplicationController

  before_action :authorize
  
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @products = Product.all
    @categories = Category.all
  end
end
