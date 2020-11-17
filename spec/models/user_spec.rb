require 'rails_helper'

RSpec.describe UserSpec, type: :model do
  describe 'Validations' do
    it 'should be valid if all fields are filled in' do
      valid_user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: '123', password_confirmation: '123')
      expect(valid_user).to be_valid
    end

    it 'should NOT be valid if first name empty' do
      @user = User.create(first_name: nil, last_name: 'Doe', email: 'test@testing.com', password: '123', password_confirmation: '123')
      expect(@user.errors.full_messages.inspect).to include("can't be blank")
    end
  end
end
