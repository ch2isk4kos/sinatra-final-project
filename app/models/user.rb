class User < ActiveRecord::Base
    has_secure_password
    validates :email, presence: true
    validates :password, presence: true
    validates_uniqueness_of :email
    validates_uniqueness_of :username

    has_many :matchups
end
