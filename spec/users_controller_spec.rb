require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe 'Friendship', type: :feature do
    let(:user) { User.create(name: 'JohnDoe', email: 'johndoe@example.com', password: '123456') }

    scenario 'accept friend' do
        current_user = User.create!(name: 'Tester', email: 'test@example.com', password: 'f4k3p455w0rd')
        login_as(current_user, scope: :user)
        user.friendships.build(friend_id: current_user.id, status: false).save

        visit users_url
        visit "/users/#{user.id}/accept"
        sleep(3)
        expect(current_path).to eq("/users")
    end

    # scenario 'decline friend' do
    #     current_user = User.create!(name: 'Tester', email: 'test@example.com', password: 'f4k3p455w0rd')
    #     login_as(current_user, scope: :user)
    #     user.friendships.build(friend_id: current_user.id, status: false).save
        
    #     visit users_url
    #     visit "/users/#{user.id}/decline"
    #     sleep(3)
    #     expect(current_path).to have_content('Friend Invitation has been sent.')
    #     #expect(page).to have_content('Friend Invitation has been sent.')
    # end
end