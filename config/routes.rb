Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope defaults: { :format => :json } do
    post  'hsm/encrypt_object'
    post  'hsm/decrypt'
    post  'hsm/decrypt_object_list'
  end
end
