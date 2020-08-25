require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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
    save_screenshot('BEFORE: Added_to_cart.png')


    # VERIFY
    page.find_link('My Cart')
    expect(page).to  have_text 'My Cart (0)'

    page.find('article', match: :first).click_on('Add')
    expect(page).to  have_text 'My Cart (1)'

    # DEBUG
    save_screenshot(' AFTER: Added_to_cart.png')

  end
end
