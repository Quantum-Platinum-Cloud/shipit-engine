class ApplicationController < ActionController::Base
  before_filter :basic_auth
  before_filter :authenticate

  def authenticate
    return if session[:user] || Settings.authentication.blank?
    redirect_to "/auth/#{Settings.authentication.provider}"
  end

  def basic_auth
    return unless Rails.env.production?
    authenticate_or_request_with_http_basic("Application") do |name, password|
      name == 'shipit' && password == 'yoloshipit'
    end
  end

  # Respond to HTML by default
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
