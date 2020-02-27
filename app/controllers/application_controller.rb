require 'auth_service'
class ApplicationController < ActionController::API
  include AuthService

  before_action :validate_authentication
end
