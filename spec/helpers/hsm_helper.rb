
def valid_data_params
  {
      obj: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            birth_date: Faker::Date.birthday,
            email: Faker::Internet.email,
          },
      key_id: nil
  }
end

def invalid_data_params
  {
      obj: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          birth_date: Faker::Date.birthday,
          email: Faker::Internet.email,
      },
      key_id: 999
  }
end

def encrypt_some_object_data
  params = ActionController::Parameters.new(valid_data_params)
  encrypted_object = HsmService.new(params)
  encrypted_object.encrypt

  [encrypted_object.encrypted_data, encrypted_object.key_id]
end
