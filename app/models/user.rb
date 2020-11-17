class User < ActiveRecord::Base

  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true, length: { minimum: 4 }


  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.delete(' '))
    if user && user.authenticate(password)
      true
    else 
      false
    end
  end

end
