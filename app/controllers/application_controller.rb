class ApplicationController < ActionController::Base
  def logged_in?
    if session[:user_id]# すでにログイン済みの場合トップにリダイレクトさせる。
      @user = User.find(session[:user_id])
      redirect_to memos_path
    end
  end

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_path #ログインを済ませていない（クッキーに情報がない）場合はログインページにリダイレクトする。
    end
  end
end
