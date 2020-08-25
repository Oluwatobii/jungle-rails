class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name, presence: { strict: true }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 } 
  validates :password_confirmation, presence: true, length: { minimum: 8 }
 
  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip # Edge case: Returns a copy of str with leading and trailing whitespace removed.

    @user = User.find_by(email: email).try(:authenticate, password)
    if @user 
      return @user 
    else 
      return false
    end
  end

  
end
