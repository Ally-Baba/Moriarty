class User < ActiveRecord::Base
    validates :username, presence: true, uniqueness: true, length: { case_sensitive: false, minimum: 3, maximum: 25 }
    VALID_EMAIL_REQEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
    before_save { self.email = email.downcase }

end
