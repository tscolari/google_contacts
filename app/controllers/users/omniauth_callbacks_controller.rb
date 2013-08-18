class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    authentication = UserAuthentication.new(self)
    @user = authentication.authenticate(request.env["omniauth.auth"])
    sign_in_and_redirect @user, :event => :authentication
  end
end
