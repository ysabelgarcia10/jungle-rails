require 'rails_helper'

# Start with a copy of all the setup (before :each) code from the home_page feature because you need the category and its products on the home page, visit it and then click one of the product partials in order to navigate directly to a product detail page.

# Refer to the code in the _product.html.erb partial to determine how you are going to select the link to click.

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
    # visit main page
    visit root_path
    
    save_screenshot 'all products page.png'
    expect(page).to have_css 'article.product', count: 10

    #click on a product for details
    item_to_click = page.all('article.product')[0].click
    item_to_click.click_on 'Details »'

    sleep 1
    save_screenshot 'after clicking the details on a specific product.png'
    expect(page).to have_css 'article.product-detail'
  end
end
