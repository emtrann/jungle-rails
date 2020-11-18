require 'rails_helper'

RSpec.feature "Cart increases by one when customers add a product", type: :feature, js: true do

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

  scenario "They see cart update +1 after add product button clicked" do
    visit root_path
    expect(page).to have_content('My Cart (0)')
    first('.actions').click_button('Add')
    expect(page).to have_content('My Cart (1)')
  end
end