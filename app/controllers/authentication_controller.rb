class AuthenticationController < ApplicationController
  def create
    # For demonstration, using a fixed user_id and shared secret
    secret = Rails.application.credentials.secret_key_base
    payload = { user_id: User.last.id, exp: 24.hours.from_now.to_i }

    token = JWT.encode(payload, secret)

    render json: { token: token }, status: :ok
  end
end
