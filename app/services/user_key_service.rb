class UserKeyService

  attr_accessor :errors, :status_code, :user_key

  def initialize(params)
    @user_id = params[:user_id]
    @errors = []
    @status_code = 200
  end

  def get_key
    first_or_initialize_user_key
  end

  private

  def first_or_initialize_user_key
    user_data = UserKey.where(user_id: @user_id).first_or_initialize(key: generate_user_key)
    user_data.save!
    @user_key = user_data.key.force_encoding("ISO-8859-1").encode("UTF-8")
  rescue => e
    check_erros(e.to_s)
  end

  def check_erros(error_message)
    @errors << {
        status_code: ERROR_STATUS_CODE,
        error_msg: error_message
    }
    @status_code = 400
  end

  def generate_user_key
    KeyGeneratorService.new(@user_id).generate_key
  end

end