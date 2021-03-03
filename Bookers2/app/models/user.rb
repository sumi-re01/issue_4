class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :uniqueness => true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}

# association Book
  has_many :books, dependent: :destroy


# association Relation
# active(フォローする)
  has_many :active_relationships, class_name:"Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed #一覧の取得
# passive(フォローされる)
  has_many :passive_relationships, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower #一覧の取得
# フォロー関係のメソッド
def follow(other_user)
  unless self == other_user
    self.active_relationships.create(followed_id: other_user.id)
  end
end

def unfollow(other_user)
  active_relationships.find_by(followed_id: other_user).destroy
end

# フォローしているかどうか
def following?(other_user)
  following.include?(other_user)
end

  attachment :profile_image
end
