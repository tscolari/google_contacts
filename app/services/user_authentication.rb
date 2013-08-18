class UserAuthentication

  def initialize(context)
    @context = context
  end

  def authenticate(omniauth_response)
    data = omniauth_response.info
    user = find_user(data) || create_user(data)
    session["oauth_credentials"] = omniauth_response.credentials
    user
  end

  private

  def find_user(data)
    User.where(email: data["email"]).first
  end

  def create_user(data)
    User.create(email: data["email"], password: Devise.friendly_token[0,20])
  end

  def session
    @context.session
  end

end
