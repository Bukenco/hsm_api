require_relative '../helpers/hsm_helper'

RSpec.describe HsmService do
  describe context "Hsm Encrypt/Decrypt Service" do


    it "should return encrypted data with key" do
      params = ActionController::Parameters.new(valid_data_params)

      encrypted_object = HsmService.new(params)
      encrypted_object.encrypt

      expect(encrypted_object.encrypted_data.present?).to be true
      expect(encrypted_object.key_id.present?).to be true
    end

    it "should return validation error for encryption" do
      params = ActionController::Parameters.new(invalid_data_params)

      encrypted_object = HsmService.new(params)
      encrypted_object.encrypt

      expect(encrypted_object.errors.any?).to be true
    end

    it "should decrypt object list" do
      encrypted_data_list, encryption_key_id = encrypt_some_object_data
      #attribute = attributes_to_decrypt

      decrypted_data = HsmService.new({ key_id: encryption_key_id, obj: [encrypted_data_list] })
      decrypted_data.decrypt_list

      expect(decrypted_data.decrypted_data.present?).to be true
      expect(decrypted_data.decrypted_data.is_a? Array).to be true
    end

  end
end