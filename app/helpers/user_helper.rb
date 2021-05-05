module UserHelper
    def request_status(user)
        if current_user.pending_friends.include?(user)
            link_to 'Invitation pending', class: 'profile-link'
          elsif !current_user.friendships.exists?(friend_id: user.id) && current_user.id != user.id && ! current_user.friend_requests.include?(user)
            link_to 'Send friend request',  "/users/#{user.id}/request", method: 'post', class: 'profile-link'
          elsif current_user.friend_requests.include?(user)
            
            concat(link_to 'Accept Request',  "/users/#{user.id}/accept", method: 'post', class: 'profile-link')
            link_to ' | Decline Request',  "/users/#{user.id}/decline", method: 'post', class: 'profile-link'
        end
    end
end