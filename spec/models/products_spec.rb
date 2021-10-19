require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid when all fields are set' do
      @category = Category.new
      params = {
      name: 'Teddy Bear',
      price_cents: 50000,
      quantity: 200,
      category: @category,
      }
      expect(Product.new(params)).to be_valid
    end

    it 'is valid when the name field is set to a value' do
      @category = Category.new
      params = {
        name: nil,
        price_cents: 3000,
        quantity: 100,
        category: @category,
      }
      expect(Product.new(params)).to_not be_valid
    end

    it 'is valid when the price field is set to a value' do
      @category = Category.new
      params = {
        name: 'The Office mug',
        price_cents: nil,
        quantity: 2030,
        category: @category,
      }
      expect(Product.new(params)).to_not be_valid
    end

    it 'is valid when the quantity field is set to a value' do
      @category = Category.new
      params = {
        name: 'Ikea lamp',
        price_cents: 20000,
        quantity: nil,
        category: @category,
      }
      expect(Product.new(params)).to_not be_valid
    end

    it 'is valid when the category field is set to a value' do
      @category = Category.new
      params = {
        name: 'Hipster glasses',
        price_cents: 10000,
        quantity: 1000,
        category: nil,
      }
      expect(Product.new(params)).to_not be_valid
    end

  end
end 