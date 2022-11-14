class Api::V1::GroupsController < ApplicationController
  before_action :set_group, only: %i[ show update destroy ]
  prepend_before_action :authenticate_scope!

  # GET /groups
  def index
    @groups = Group.all

    render json: @groups
  end

  # GET /groups/1
  def show
    render json: @group
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      render json: {status: "SUCCESS", message: "Group was created successfully!", data: @group}, status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update!(group_params)
      render json: {message: "Group was updated successfully", data: @group}, status: :ok
    else
      render json: {message: "Group cannot be updated"}, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    if @group.destroy!
      render json: {message: "Group was deleted successfully"}, status: :ok
    else
      render json: {message: "Group does not exist"}, status: :bad_request
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
