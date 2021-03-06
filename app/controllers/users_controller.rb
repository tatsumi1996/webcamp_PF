class UsersController < ApplicationController
    before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @supports = @user.supports.page(params[:page]).per(15)
    @support = Support.new
  end

  def index
    @users = User.all.page(params[:page]).per(15)
    @support = Support.new
  end

  def edit
    @favorite_teams = FavoriteTeam.all
    @user = User.find(params[:id])
    if current_user != @user
		  flash[:notice] = "権限がありません"
		  redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "アカウント情報の更新が完了しました。"
    else
      render "edit"
    end
  end
	
  def hide
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :introduction, :profile_image, :favorite_team_id)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
