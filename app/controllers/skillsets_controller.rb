class SkillsetsController < ApplicationController

  def new
    @skillsets = Skillset.new()
    @user = current_user
  end

  def create
    SkillsetManager.new(params[:user][:cuisine_ids], current_user).run
    redirect_to user_path(current_user)
  end

end