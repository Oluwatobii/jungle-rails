require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
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
  

    User.create!({
        first_name: 'Lisa',
        last_name: 'Simpson',
        email: 'lisasimpson@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      })
  end


  scenario "They see all products" do
    # ACT
    visit '/login'

    # DEBUG
    save_screenshot(' BEFORE: user_login.png')

    fill_in 'email', with: 'lisasimpson@gmail.com'
    fill_in 'password',  with: 'password'
    click_on 'Submit'

    # VERIFY
    expect(page).to  have_text 'Logout'

    # DEBUG
    save_screenshot(' AFTER: user_login.png')
  end
end
