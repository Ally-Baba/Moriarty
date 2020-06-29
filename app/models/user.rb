class User < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :username, presence: true, uniqueness: true, length: { case_sensitive: false, minimum: 3, maximum: 25 }
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
    before_save { self.email = email.downcase }
    has_secure_password
    has_many :articles
    before_save { self.email = email.downcase }
end
