class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  def friends
    friendships.map { |friendship| friendship.friend if friendship.status }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def accept_friendship(user_id)
    request = inverse_friendships.where(user_id: user_id).where(status: false).first
    request.status = true
    request.save

    friendships.build(friend_id: user_id, status: true).save
  end

  def decline_friendship(user_id)
    request = inverse_friendships.where(user_id: user_id).where(status: false).first
    request.destroy
  end
end
