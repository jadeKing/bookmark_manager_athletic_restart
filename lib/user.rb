require 'bcrypt'
class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password, message: 'Sorry the passwords dont match'
  validates_uniqueness_of :email

  property :id, Serial
  # unique - database level constraint (validation)
  property :email, String, unique: true
  # password is hashed, must be text not string as string not long enough
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    user if user && BCrypt::Password.new(user.password_digest) == password
  end
end
