class KeyGeneratorService

  def initialize(user_password)
    @password = user_password.to_s
    @salt = SecureRandom.random_bytes(64)
  end

  def generate_key
    ActiveSupport::KeyGenerator.new(@password).generate_key(@salt)
  end
end