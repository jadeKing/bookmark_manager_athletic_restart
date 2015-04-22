require 'bcrypt'
class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  # password is hashed, must be text not string as string not long enough
  property :password_digest, Text

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
end
