require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it 'should be valid if name, price, quant and cat exist' do
      @cat1 = Category.new name: 'Apparel'
      valid_product = Product.create(name: 'prod1', price: '123', quantity: 20, category: @cat1)
      expect(valid_product.errors.full_messages).to eq([])
    end

    it 'should be invalid if name was not inputted' do
      @cat1 = Category.new name: 'Apparel'
      @product = Product.create(name: nil, price: '123', quantity: 20, category: @cat1)
      expect(@product.errors.full_messages.inspect).to include("can't be blank")
    end

    it 'should be invalid if price was not inputted' do
      @cat1 = Category.new name: 'Apparel'
      @product = Product.create(name: 'nice shirt', price: nil, quantity: 20, category: @cat1)
      expect(@product.errors.full_messages.inspect).to include("can't be blank")
    end

    it 'should be invalid if quantity was not inputted' do
      @cat1 = Category.new name: 'Apparel'
      @product = Product.create(name: 'nice shirt', price: 123, quantity: nil, category: @cat1)
      expect(@product.errors.full_messages.inspect).to include("can't be blank")
    end

    it 'should be invalid if category was not inputted' do
      @cat1 = Category.new name: 'Apparel'
      @product = Product.create(name: 'nice shirt', price: 123, quantity: nil, category: nil)
      expect(@product.errors.full_messages.inspect).to include("can't be blank")
    end
  end

end