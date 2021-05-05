class Friendship < ApplicationRecord
  scope :pending_requests, -> { where(status: false) }
  
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
