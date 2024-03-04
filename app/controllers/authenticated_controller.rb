class AuthenticatedController < ApplicationController
  before_action :authenticate_request

  private

  def authenticate_request
    # Warning this is not a legit authentication.  It hard-loads User.last
    # Normally this authentication should result in a successful response to
    # a challenge or a valid session cookie
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @current_user = nil
    begin
      @decoded = JWT.decode(header, Rails.application.credentials.secret_key_base)[0]
      @current_user = User.find(@decoded['user_id']) rescue nil
      render_unauthorized_error unless @current_user
    rescue JWT::DecodeError
      render_unauthorized_error
    end
  end

  def render_unauthorized_error(err_msg: 'Unauthorized')
    render json: { errors: err_msg }, status: :unauthorized
  end
end

