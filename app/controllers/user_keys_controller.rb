class UserKeysController < ApplicationController

  def get_user_key
    data = UserKeyService.new(user_params)
    data.get_key
    return render json: { errs: data.errors }, status: data.status_code if data.errors.any?
    render json: { user_key: data.user_key }
  end

  private

  def user_params
    params.permit(:user_id)
  end
end
