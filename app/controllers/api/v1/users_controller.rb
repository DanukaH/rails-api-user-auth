class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  load_and_authorize_resource

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: {message: "User was updated successfully", data: @user}, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy!
      render json: {message: "User was deleted successfully"}, status: :ok
    else
      render json: {message: "User does not exist"}, status: :bad_request
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :admin)
  end
end
