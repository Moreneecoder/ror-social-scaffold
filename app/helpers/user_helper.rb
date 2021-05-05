module UserHelper
    def request_status(user)
        if current_user.pending_friends.include?(user)
            link_to 'Invitation pending', class: 'profile-link'
          elsif !current_user.friendships.exists?(friend_id: user.id) && current_user.id != user.id
            link_to 'Send friend request',  "/users/#{user.id}/request", method: 'post', class: 'profile-link'
        end
    end
end