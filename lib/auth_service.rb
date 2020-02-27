module AuthService

  def validate_authentication
    @result = Auth::ValidateTokenService.new(bearer_token).call
    unless @result.present?
      render json: {status: ERROR_STATUS_CODE}, status: 401
    end
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"]
    header.gsub(pattern, '') if header&.match(pattern)
  end

end