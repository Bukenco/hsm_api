module Auth
  class Hmac

    def algorithm
      'HS256'
    end

    def decode_token(token)
      decode(token)
    end

    def secret_key
      Rails.application.credentials[Rails.env.to_sym][:jwt_secret_key]
    end

    private

    def decode(token)
      JWT.decode(token, secret_key, true, { algorithm: algorithm } )
    end
  end
end