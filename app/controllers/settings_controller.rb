class SettingsController < ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(settings_params)
      redirect_to settings_path, notice: "Configuración actualizada."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def settings_params
    params.require(:user).permit(:business_name, :email)
  end
end