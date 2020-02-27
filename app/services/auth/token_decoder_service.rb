module Auth
  class TokenDecoderService
    attr_reader :token, :provider, :type

    def initialize(token , provider)
      @token = token
      @provider = provider
    end

    def decode
      provider.decode_token(token)
    end
  end
end