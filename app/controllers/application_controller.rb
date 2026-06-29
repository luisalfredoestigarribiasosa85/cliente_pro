class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def current_business
    current_user.business_name if current_user
  end

  def scope_to_user
    yield(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:business_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:business_name])
  end
end