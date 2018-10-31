class UsersController < ApplicationController

  skip_before_action :require_sign_in!, only: [:login, :create]

  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])#request.env['omniauth.auth']はTwitter認証で得た情報を格納するもの
    if user
      sign_in(user)
      redirect_to '/', notice: "ログインしました。"
    else
      redirect_to root_path, notice: "失敗しました。"
    end
  end

  def login
  end

  def logout
    sign_out
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
end
