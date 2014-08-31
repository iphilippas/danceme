require 'mongoid'
require 'bcrypt'

module DanceMe
	
	class User
		include Mongoid::Document
		include BCrypt
		
		attr_accessor :password, :password_confirmation
  	attr_protected :password_hash

		field :uid, type: String
		field :username, type: String
		field :email, type: String
		field :password_hash, type: String
		field :admin, type: Boolean
		
		validates_presence_of :email, message: "Email Address is Required."
  	validates_uniqueness_of :email, message: "Email Address Already In Use. Have You Forgot Your Password?"
  	validates_format_of :email, with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, message: "Please Enter a Valid Email Address."
  	validates_length_of :password, minimum: 8, message: "Password Must Be Longer Than 8 Characters."
  	validates_confirmation_of :password, message: "Password Confirmation Must Match Given Password."

		before_save :encrypt_password, :assign_default_role

		def is_admin?
			return self.admin
		end

		protected
		def encrypt_password
			self.password_hash = Password.create(self.password)
		end

		def assign_default_role
			self.admin = nil
		end
	end

	class Article
		include Mongoid::Document

		field :title, type: String
		field :body, type: String
	end	

end
