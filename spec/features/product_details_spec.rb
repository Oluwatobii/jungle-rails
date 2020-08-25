require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG 
    save_screenshot('BEFORE: product_page.png')
    
    # VERIFY
    page.find('article', match: :first).click_on('Details')
    expect(page).to have_css 'section.products-show'

    # DEBUG 
    save_screenshot('AFTER: product_page.png')
  end
end
