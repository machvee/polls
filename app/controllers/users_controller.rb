class UsersController < AuthenticatedController
  def index
    render json: [current_user]
  end
end
