class FollowingUsersController < ApplicationController
  before_action :load_user

  def following
    @title = t "follow.following_upcase"
    @users = @user.following.order(:name).page params[:page]
    render "show_follow"
  end

  def followers
    @title = t "follow.follower_upcase"
    @users = @user.followers.order(:name).page params[:page]
    render "show_follow"
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
     redirect_to "/404"
    end
  end
end
