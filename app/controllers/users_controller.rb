class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:alert] = "Vous ne pouvez pas accéder à la page de profil d'un autre utilisateur."
      redirect_to events_path
    end
  end

end