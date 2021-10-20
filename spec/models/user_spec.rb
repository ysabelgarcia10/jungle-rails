require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(first_name: 'Jane', 
                        last_name: 'Doe', 
                        email: 'jane@gmail.com', 
                        password: 'password',
                        password_confirmation: 'password')
  }


  describe 'Validations' do
    it 'is valid when password and password_confirmation match' do
      expect(subject).to be_valid
    end

    it 'is invalid when password and password_confirmation do not match' do
      subject.password_confirmation = 'differentpassword'
      expect(subject).to_not be_valid
    end

    it 'is invalid when either password or password_confirmation are empty' do
      subject.password = nil
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid when first name is empty' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid when last name is empty' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid when email is empty' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid if password is less than 6 characters' do
      subject.password = '123'
      subject.password_confirmation = '123'
      expect(subject).to_not be_valid
    end

  end

  context 'Unique Email' do
    before { 
      described_class.create!(first_name: 'Janey', 
                              last_name: 'Smith',
                              email: 'jaNe@gmail.COM',
                              password: '123456',
                              password_confirmation: '123456') 
    }
    it 'is invalid if email is not unique' do    
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    user = User.create(first_name: 'Teddy', 
                         last_name:'Bear', 
                         email: 'teddy@gmail.com', 
                         password: 'teddybear', 
                         password_confirmation: 'teddybear')

    it 'returns instance of the user if successfully authenticated' do
      authenticated_user = User.authenticate_with_credentials('teddy@gmail.com', 'teddybear')
      expect(authenticated_user).to eq(user)
    end

    it 'returns nil if user is not successfully authenticated' do
      authenticated_user = User.authenticate_with_credentials('ted@gmail.com', 'teddybear')
      expect(authenticated_user).to be(nil)
    end

    it 'returns user even if there are spaces' do
      authenticated_user = User.authenticate_with_credentials('   teddy@gmail.com ', 'teddybear')
      expect(authenticated_user).to eq(user)
    end

    it 'returns user even if there are wrong case in the email' do
      authenticated_user = User.authenticate_with_credentials('tEDDy@GMAIL.com', 'teddybear')
      expect(authenticated_user).to eq(user)
    end
  end

end
