require 'bcrypt'
class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_unoiqueness_of :email

  property :id, Serial
  # unique - database level constraint (validation)
  property :email, String, unique: true
  # password is hashed, must be text not string as string not long enough
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
