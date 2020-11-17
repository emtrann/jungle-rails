class User < ActiveRecord::Base

  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true, length: { minimum: 4 }

  before_save {email = email.downcase}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    user && user.authenticate(password)
  end

end
