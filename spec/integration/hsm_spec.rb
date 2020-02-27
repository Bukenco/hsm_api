require 'swagger_helper'
describe 'Hsm' do

  path '/hsm/encrypt_object' do
    post 'Encrypt data' do
      tags 'Hsm'
      consumes 'application/json'

      #parameter({
      #              :in => :header,
      #              :type => :string,
      #              :name => :Authorization,
      #              :required => true,
      #              :description => 'Client token'
      #          })
      parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            obj: {
                type: :object,
                properties: {
                    key:      { type: :string  }
                }
            },
            key_id: { type: :integer}
          }

      }

      response '200', 'OK' do
        schema type: :object,
               properties: {
                   encrypted_data: {
                       type: :object,
                       properties: {
                           key:             { type: :string },
                           key_encrypted:   { type: :string }
                       }
                   },
                   key_id: { type: :integer}
               }

        let(:params) do
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

        run_test!
      end

      response '400', 'Bad request' do

        schema type: :object,
               properties: {
                   errs: {
                       type: :array,
                       items: {type: :string}
                   }
               }

        let(:params) do
          {
              obj: {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  birth_date: Faker::Date.birthday,
                  email: Faker::Internet.email,
              },
              key_id: 99999999999999999

          }
        end

        run_test!
      end

      #response '401', 'unauthorized' do
      #
      #  schema type: :object,
      #         properties: { }
      #
      #  let(:params) do
      #    {
      #        obj: {
      #            first_name: Faker::Name.first_name,
      #            last_name: Faker::Name.last_name,
      #            birth_date: Faker::Date.birthday,
      #            email: Faker::Internet.email,
      #        },
      #        user_id: 1
      #
      #    }
      #  end
      #
      #  run_test!
      #end

    end
  end

  path '/hsm/decrypt_object_list' do
    post 'Decrypt data list' do
      tags 'Hsm'
      consumes 'application/json'

      #parameter({
      #              :in => :header,
      #              :type => :string,
      #              :name => :Authorization,
      #              :required => true,
      #              :description => 'Client token'
      #          })
      parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
              obj: {
                  type: :array,
                  items: {
                      type: :object,
                      properties: {
                          id:       { type: :integer  },
                          key:      { type: :string  }
                      }
                  }
              },
              key_id: { type: :integer}
          }

      }

      response '200', 'OK' do
        schema type: :object,
               properties: {
                   decrypted_data: {
                       type: :array,
                       items: {
                           type: :object,
                           properties: {
                               id:   { type: :integer },
                               key:  { type: :string }
                           }
                       }
                   }
               }

        before do
          @encrypted_object = HsmService.new({ key_id: nil, obj: { first_name: "test_name", last_name: "test_last_name"  } })
          @encrypted_object.encrypt
          @encrypted_object_second = HsmService.new({ key_id: @encrypted_object.key_id, obj: { first_name: "test_name_second", last_name: "test_last_name_second"  } })
          @encrypted_object_second.encrypt
        end

        let(:params) do
          {
              obj: [
                  {   id: 100,
                      first_name_encrypted: @encrypted_object.encrypted_data[:first_name_encrypted],
                      last_name_encrypted: @encrypted_object.encrypted_data[:last_name_encrypted]
                  },
                  {
                      id: 101,
                      first_name_encrypted: @encrypted_object_second.encrypted_data[:first_name_encrypted],
                      last_name_encrypted: @encrypted_object_second.encrypted_data[:last_name_encrypted]
                  }
              ],
              attributes: %w(first_name last_name),
              key_id: @encrypted_object.key_id

          }
        end

        run_test!
      end

      response '400', 'Bad request' do

        schema type: :object,
               properties: {
                   errs: {
                       type: :array,
                       items: {type: :string}
                   }
               }

        before do
          @encrypted_object = HsmService.new({ key_id: nil, obj: { first_name: "test_name", last_name: "test_last_name"  } }).encrypt
        end

        let(:params) do
          {
              obj: [
                  {
                  first_name_encrypted: @encrypted_object[:first_name_encrypted],
                  last_name_encrypted: @encrypted_object[:last_name_encrypted]
                  }
              ],
              attributes: %w(first_name last_name),
              key_id: nil

          }
        end

        run_test!
      end

      #response '401', 'unauthorized' do
      #
      #  schema type: :object,
      #         properties: { }
      #
      #  run_test!
      #end

    end
  end
end