class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_filter :set_locale
  def set_locale
    I18n.locale = extract_locale_from_subdomai
  end
  
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : I18n.default_locale
  end
  
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
