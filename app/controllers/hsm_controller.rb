class HsmController < ApplicationController

  def encrypt_object
    data = HsmService.new(encrypt_params)
    data.encrypt

    if data.errors.any?
      render json: { errs: data.errors }, status: 400
    else
      render json: { encrypted_data: data.encrypted_data, key_id: data.key_id }
    end
  end

  def decrypt_object_list
    data = HsmService.new(params)
    data.decrypt_list

    if data.errors.any?
      render json: { errs: data.errors }, status: 400
    else
      render json: { decrypted_data: data.decrypted_data }
    end
  end

  private

  def encrypt_params
    params.permit(:key_id, obj: {})
  end

end
