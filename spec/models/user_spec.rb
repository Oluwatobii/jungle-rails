require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before (:each) do
    @user = User.new({
      first_name: 'Lisa',
      last_name: 'Simpson',
      email: 'lisasimpson@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    })

    @user.save
  end

  describe 'Validations' do

    it "Able to save a user when their passwords match" do
      @found_user = User.where(first_name: 'Lisa')
      # puts "Found user: #{@found_user.inspect}"
      expect(@found_user).to exist

    end

    it "is not valid email has required input" do
      @user.email = nil
      expect(@user.validate).to be false
    end

    it "Unable to save a user when their passwords doesn't match" do
      @user = User.new({
        first_name: 'Bart',
        last_name: 'Simpson',
        email: 'bartsimpson@gmail.com',
        password: 'password',
        password_confirmation: 'wrongpassword'
      })

      @user.save


      @found_user = User.where(first_name: 'Bart')
      expect(@found_user).not_to exist

    end

    it "Unable to save a user when their email isn't unique" do
      @user = User.new({
        first_name: 'Bart',
        last_name: 'Simpson',
        email: 'lisasimpson@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      })

      @user.save


      @found_user = User.where(first_name: 'Bart')
      expect(@found_user).not_to exist
    end

    it "Unable to save a user when the password is less than the specified length of characters (8)" do
      @user = User.new({
        first_name: 'Bart',
        last_name: 'Simpson',
        email: 'bartsimpson@gmail.com',
        password: 'lessd8',
        password_confirmation: 'lessd8'
      })

      @user.save

      @found_user = User.where(first_name: 'Bart')
      expect(@found_user).not_to exist
    end
  end

  describe '.authenticate_with_credentials'  do
    it "Able to log in with correct email and password"  do
      check_user = User.authenticate_with_credentials('lisasimpson@gmail.com', 'password')
      # p "check_user #{check_user.inspect}"
      expect(check_user.validate).to_not be_nil
    end
    it "Accounting for whitespaces from emails"  do
      check_user = User.authenticate_with_credentials('   lisasimpson@gmail.com   ', 'password')
      # p "check_user #{check_user.inspect}"
      expect(check_user).to_not be_nil
    end
    it "Able to account for wrong case for their email address"  do
      check_user = User.authenticate_with_credentials('lIsaSimPsoN@gmAil.CoM', 'password')
      # p "check_user #{check_user.inspect}"
      expect(check_user).to_not be_nil
    end
    it "Not able to log in with wrong password"  do
      check_user = User.authenticate_with_credentials('lisasimpson@gmail.com', 'wrongpassword')
      # p "check_user #{check_user.inspect}"
      expect(check_user).to be false
    end
  end
end
