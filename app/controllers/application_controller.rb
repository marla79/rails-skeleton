class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :detect_locale

  def detect_locale
    if params[:locale].present?
      I18n.locale = params[:locale]
    else
      if request.method == "GET"
        new_locale = http_accept_language.compatible_language_from(I18n.available_locales.map(&:to_s))
        new_locale = I18n.default_locale.to_s unless new_locale
        redirect_to url_for(locale: new_locale)
      end
    end
  end

end
