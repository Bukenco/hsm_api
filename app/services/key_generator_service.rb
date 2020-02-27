class KeyGeneratorService

  def initialize(user_id)
    @user_id= user_id.to_s
  end

  def generate_key
    len = ActiveSupport::MessageEncryptor.key_len
    @salt = SecureRandom.random_bytes(len)
    ActiveSupport::KeyGenerator.new(@user_id).generate_key(@salt, len)
  end
end