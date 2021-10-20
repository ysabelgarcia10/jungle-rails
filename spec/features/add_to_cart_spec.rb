require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature , js: true do
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

  scenario "They can add item to cart" do
    # visit main page
    visit root_path

    save_screenshot 'cart - 0 - all products page.png'
    expect(page).to have_css 'article.product', count: 10
    expect(page).to have_content(' My Cart (0) ')

    #click on a product for details
    item_to_click = page.all('article.product')[0].click
    item_to_click.click_on 'Add'

    sleep 1
    save_screenshot 'cart - 1 - after clicking the details on a specific product.png'
    expect(page).to have_content(' My Cart (1) ')
  end
end
