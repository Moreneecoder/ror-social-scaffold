require 'rails_helper'

RSpec.describe 'Friendship', type: :feature do
  include Warden::Test::Helpers
  Warden.test_mode!

  let(:user) { User.create(name: 'JohnDoe', email: 'johndoe@example.com', password: '123456') }
  let(:current_user) { User.create!(name: 'Tester', email: 'test@example.com', password: 'f4k3p455w0rd') }

  scenario 'request friend' do
    login_as(current_user, scope: :user)

    visit users_url
    visit "/users/#{user.id}/request"
    sleep(3)
    expect(page).to have_content('Friend Request Successfully Sent')
  end

  scenario 'accept friend' do
    login_as(current_user, scope: :user)
    user.friendships.build(friend_id: current_user.id, status: false).save

    visit users_url
    visit "/users/#{user.id}/accept"
    sleep(3)
    expect(current_path).to eq('/users')
  end

  scenario 'decline friend' do
    login_as(current_user, scope: :user)
    user.friendships.build(friend_id: current_user.id, status: false).save

    visit users_url
    visit "/users/#{user.id}/decline"
    sleep(3)
    expect(page).to have_content("You Declined #{user.name}'s Friend Request!")
  end
end
