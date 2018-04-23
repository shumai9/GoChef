class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    render 'edit'
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      if @user.update_attributes(user_params)
        redirect_to user_path(@user)
      else
        render edit_user_registration
      end
    else
      redirect_to ('/')
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :location_lat, :location_lon,
       :max_party_size, :price_per_head, :bio, :avatar, :radius)
  end
end
