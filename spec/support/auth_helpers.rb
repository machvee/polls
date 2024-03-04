module AuthHelpers
  def token_for(user)
    # Your logic to generate a token for a user, e.g.:
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)
  end
end
