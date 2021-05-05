require 'rails_helper'

RSpec.describe 'Authenticate', type: :feature do
    let(:user) { User.create(name: 'JohnDoe', email: 'johndoe@example.com', password: '123456') }

    scenario 'login' do
      visit new_user_session_url
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      sleep(3)
      expect(current_path).to eq("/")
    end
  end