class User < ApplicationRecord
  has_many :recipes

  has_secure_password
  validates :email, presence: true, allow_blank: false
  validates :email, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { in: 6..20 }
  attr_accessor :username

  def self.login_from_omniauth(auth)
    find_from_omniauth(auth) || create_from_omniauth(auth)
  end

  def self.find_from_omniauth(auth)
    find_by(:email => auth[:info][:email])
  end

  def self.create_from_omniauth(auth)
    create(
      :email => auth[:info][:email],
      :password => Password.pronounceable(10)) 
  end

  def username
    @username = email.match(/.+(?=@)/)[0]     
  end 

end
