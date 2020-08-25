class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name, presence: { strict: true }
  # validates :email, presence: true, uniqueness: true, confirmation: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }
 
  def self.authenticate_with_credentials(email, password)
    # email = email.strip # Edge case: Returns a copy of str with leading and trailing whitespace removed.
    email = email.downcase.strip 

    @user = User.find_by(email: email).try(:authenticate, password)
    # puts "USER: #{@user.inspect}"
    return @user
  end

  
end
