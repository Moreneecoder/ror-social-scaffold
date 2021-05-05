require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'name' do
      it 'must be present' do
        user = described_class.new(name: 'John', email: 'john@example.com', password: '123456')
        expect(user).to be_valid
        user.name = nil
        expect(user).to_not be_valid
      end
    end

    describe 'email' do
      it 'must be present' do
        user = described_class.new(name: 'John', email: 'john@example.com', password: '123456')
        expect(user).to be_valid
        user.email = nil
        expect(user).to_not be_valid
      end
    end

    describe 'password' do
      it 'must be present' do
        user = described_class.new(name: 'John', email: 'john@example.com', password: '123456')
        expect(user).to be_valid
        user.password = nil
        expect(user).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many sent friendships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many received friendships' do
      user = User.reflect_on_association(:inverse_friendships)
      expect(user.macro).to eq(:has_many)
    end
  end
end
