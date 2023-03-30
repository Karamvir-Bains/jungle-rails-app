require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should create a user without an error" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      expect { subject.save }.not_to raise_error
    end

    it "should expect an error for empty first_name" do
      subject.first_name = nil
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(subject.errors.full_messages).to include("First name can't be blank")
    end

    it "should expect an error for empty last_name" do
      subject.first_name = "Alex"
      subject.last_name = nil
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(subject.errors.full_messages).to include("Last name can't be blank")
    end

    it "should expect an error for empty email" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = nil
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end

    it "should expect an error for empty password" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = nil
      subject.password_confirmation = "password"
      subject.save
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end

    it "should expect an error if password and password_confirmation don't match" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "123"
      subject.save
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should expect an error if the password is less than 8 characters" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "pass"
      subject.password_confirmation = "pass"
      subject.save
      expect(subject.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'should generate an error if the email is not unique' do
      user_1 = described_class.new
      user_1.first_name = "Alex"
      user_1.last_name = "Johnson"
      user_1.email = "alex.johnson1234@gmail.com"
      user_1.password = "password"
      user_1.password_confirmation = "password"
      expect { user_1.save }.not_to raise_error

      user_2 = described_class.new
      user_2.first_name = "Alex"
      user_2.last_name = "Johnson"
      user_2.email = "alex.johnson1234@gmail.com"
      user_2.password = "password"
      user_2.password_confirmation = "password"
      user_2.save
      expect(user_2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe ".authenticate_with_credentials" do
    it "should login a user without an error" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(User.authenticate_with_credentials(subject.email, subject.password)).to be_an_instance_of described_class
    end

    it "should expect nil for incorrect email" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(User.authenticate_with_credentials("alexjohnson12345@gmail.com", subject.password)).to be_nil
    end

    it "should expect nil for incorrect password" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(User.authenticate_with_credentials("alex.johnson1234@gmail.com", '123')).to be_nil
    end

    it "should strip email and login without an error" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(User.authenticate_with_credentials(" alex.johnson1234@gmail.com ", subject.password)).to be_an_instance_of described_class
    end

    it "should downcase email and login without an error" do
      subject.first_name = "Alex"
      subject.last_name = "Johnson"
      subject.email = "alex.johnson1234@gmail.com"
      subject.password = "password"
      subject.password_confirmation = "password"
      subject.save
      expect(User.authenticate_with_credentials("AlEx.jOhNsoN1234@gmAiL.cOm", subject.password)).to be_an_instance_of described_class
    end
  end
end
