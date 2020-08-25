require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Validations' do
    # validation tests/examples here
    before (:each) do
      @category = Category.find_or_create_by name: 'Toy'
      
      # @product = Product.new({
      #   name: 'LEGO Simpsons House',
      #   price_cents: '349.90',
      #   quantity: 1
      # })
  
      @category.products.create({
        name: 'LEGO Simpsons House',
        price_cents: '349.90',
        quantity: 1
      })
    end
      
    it 'Saves a new category and product when created' do
      expect(Category.where(name: 'Toy')).to exist
      expect(Product.where(name: 'LEGO Simpsons House')).to exist
    end

    it 'displays the product name' do
      @testing_prod = Product.where(name: 'LEGO Simpsons House')
      expect(@testing_prod.name).to be_present
    end

    it 'displays the product price' do
      @testing_prod = Product.where(name: 'LEGO Simpsons House')
      expect(@testing_prod.first.attributes["price_cents"]).to be_present
    end

    it 'shows the quantity of said' do
      @testing_prod = Product.where(name: 'LEGO Simpsons House')
      expect(@testing_prod.first.attributes["quantity"]).to be_present
    end

    it 'has a product category' do
      @testing_prod = Product.where(name: 'LEGO Simpsons House')
      expect(@testing_prod.first.attributes["category_id"]).to be_present
    end
  end
end
