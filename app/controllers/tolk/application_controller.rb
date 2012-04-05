module Tolk
  class ApplicationController < ActionController::Base
    helper :all
    protect_from_forgery

    cattr_accessor :authenticator
    before_filter :authenticate

    def authenticate
      #self.authenticator.bind(self).call if self.authenticator && self.authenticator.respond_to?(:call)
      if !(::ALLOWED_HOSTNAMES.include?(Socket.gethostname))
        return render :text => 'No permission', :status => 403 
      end

      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == ::USERNAME && password == ::PASSWORD
      end

    end

    def ensure_no_primary_locale
      redirect_to tolk_locales_path if @locale.primary?
    end

  end
end
