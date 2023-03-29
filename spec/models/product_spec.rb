require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should create a product without an error' do
      subject.name = "Cliff Collard"
      subject.price = 79.99
      subject.quantity = 1
      subject.category = Category.new(name: 'Evergreen')
      expect { subject.save }.not_to raise_error
    end
    it 'should expect an error for empty name' do
      subject.name = nil
      subject.price = 79.99
      subject.quantity = 1
      subject.category = Category.new(name: 'Evergreen')
      subject.save
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end
    it 'should expect an error for empty price' do
      subject.name = "Cliff Collard"
      subject.quantity = 1
      subject.category = Category.new(name: 'Evergreen')
      subject.save
      expect(subject.errors.full_messages).to include("Price is not a number")
    end
    it 'should expect an error for empty quantity' do
      subject.name = "Cliff Collard"
      subject.price = 79.99
      subject.quantity = nil
      subject.category = Category.new(name: 'Evergreen')
      subject.save
      expect(subject.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should expect an error for empty category' do
      subject.name = "Cliff Collard"
      subject.price = 79.99
      subject.quantity = 1
      subject.category = nil
      subject.save
      expect(subject.errors.full_messages).to include("Category can't be blank")
    end
  end
end
