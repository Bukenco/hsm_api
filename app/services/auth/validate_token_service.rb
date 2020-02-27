module Auth
  class ValidateTokenService
    attr_reader :token, :type
    def initialize(token)
      @token = token
    end

    def call
      decoded_token_data = TokenDecoderService.new(token, Hmac.new).decode
      token_expired_at = DateTime.parse(decoded_token_data[0]['expired_at'])

      if token_expired_at > DateTime.now
        decoded_token_data
      else
        nil
      end
    rescue
      nil
    end
  end
end