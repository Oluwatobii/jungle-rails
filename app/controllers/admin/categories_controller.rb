class Admin::CategoriesController < ApplicationController

  before_action :authorize
  
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def index
    @products = Product.group(:category).all
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(name: params[:category][:name])

    if @category.save
      redirect_to [:admin, :categories], notice: "Category created!"
    else
      render new
    end
  end

  

end
