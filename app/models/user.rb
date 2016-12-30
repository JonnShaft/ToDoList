class User < ApplicationRecord
  has_secure_password #Uses bcrypt algorythm to securely hash user p/ws.
end
