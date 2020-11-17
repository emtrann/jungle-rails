require 'rails_helper'

RSpec.describe UserSpec, type: :model do
  describe 'Validations' do
    it 'should be valid if all fields are filled in' do
      valid_user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: '1234', password_confirmation: '1234')
      expect(valid_user).to be_valid
    end

    it 'should NOT be valid if first name empty' do
      user = User.create(first_name: nil, last_name: 'Doe', email: 'test@testing.com', password: '1234', password_confirmation: '1234')
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should NOT be valid if last name empty' do
      user = User.create(first_name: 'John', last_name: nil, email: 'test@testing.com', password: '1234', password_confirmation: '1234')
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should NOT be valid if email empty' do
      user = User.create(first_name: 'John', last_name: 'Doe', email: nil, password: '1234', password_confirmation: '1234')
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should NOT be valid if password empty' do
      user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: nil, password_confirmation: '1234')
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should NOT be valid if password confirmtion empty' do
      user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: '1234', password_confirmation: nil)
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should NOT be valid if email already exists' do
      user1 = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: '1234', password_confirmation: '1234')

      user2 = User.create(first_name: 'John', last_name: 'Doe', email: 'test@TESTING.com', password: '1234', password_confirmation: '1234')
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate only if password matches' do
      user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: '1234', password_confirmation: '1234')
      expect(user.authenticate_with_credentials(user.email, 'meowww')).to be(false)
      expect(user.authenticate_with_credentials(user.email, user.password)).to be(true)
    end

    it 'should authenticate even with spaces around email' do
      user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: '1234', password_confirmation: '1234')
      expect(user.authenticate_with_credentials("    #{user.email}    ", user.password)).to be(true)
    end

    it 'should authenticate whether email is upper/lowercase' do
      user = User.create(first_name: 'John', last_name: 'Doe', email: 'test@testing.com', password: '1234', password_confirmation: '1234')
      expect(user.authenticate_with_credentials("TEST@TESTING.com", user.password)).to be(true)
    end
  end
end
