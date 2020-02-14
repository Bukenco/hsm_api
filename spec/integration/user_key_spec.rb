require 'swagger_helper'
#require_relative '../helpers/pharmacies_helper'
describe 'UserKey' do

  path '/user_keys/get_user_key' do

    get 'Get User Key' do
      tags 'User Key'
      consumes 'application/json'

      #parameter({
      #              :in => :header,
      #              :type => :string,
      #              :name => :Authorization,
      #              :required => true,
      #              :description => 'Client token'
      #          })

      parameter name: :user_id, in: :query, type: :integer

      response '200', 'OK' do

        schema type: :object,
               properties: {
                   user_key:  { type: :string }
               }

        #let(:params) { resource_params }
        #let(:Authorization){"Bearer "+ @jwt}

        run_test!
      end

      response '400', 'Bad request' do

        schema type: :object,
               properties: {
                   status_code:  { type: :integer },
                   error_msg:    { type: :string }
               }

        #let(:params) { invalid_params}
        #let(:Authorization){"Bearer "+ @jwt}

        run_test!
      end

      response '401', 'unauthorized' do

        schema type: :object,
               properties: { }

        #let(:params){ { resource_prices: @params } }
        #let(:Authorization){"Bearer "+ ""}

        run_test!
      end

    end
  end
end