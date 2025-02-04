class UsersController < ApplicationController
  # before_action :authenticate

  def create
    user = User.new(user_params)

    if user.password == user.password_confirmation
      if user.save
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "password confirmation does not match" }, status: :unprocessable_entity
    end
  end

  def show
    if current_user
      render json: current_user
    else
      render json: { error: "Not authenticated" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
