class ApplicationController < ActionController::Base

  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?

  def current_user
    remember_token = User.encrypt(cookies[:user_remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
    if @current_user
      @current_user_image_url = @current_user.image_url.sub(/http/, 'https')
    end
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:user_remember_token)
  end

  def signed_in?
    @current_user.present?
  end

  private

    def require_sign_in!
      flash[:notice] = "ログインが必要です" unless signed_in?
      redirect_to "/login" unless signed_in?
    end

end
