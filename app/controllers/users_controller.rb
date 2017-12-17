class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy
  before_action :load_user, except: [:index, :new, :create, :edit]

  def index
   @users = User.all.order(:name).page params[:page]
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page]
    redirect_to root_url unless @user
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "notification.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "notification.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t "notification.login_please"
        redirect_to login_url
      end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "notification.deleted"
      redirect_to users_url
    else
      flash[:error] = t "notification.user_not_deleted"
      redirect_to users_url
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def verify_admin
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    redirect_to "/404" if @user.nil?
  end

end
