class UsersController < ApplicationController

  before_action :logged_in?, only: [:new, :create] #newとcreateアクション（registerページへ遷移）が実行された時にのみlogged_in?を発火させる。
  before_action :current_user, only: [:index, :edit, :update] #認証されているかを先にチェックする。


  def index #ユーザー詳細情報を表示する。
    @user = User.find(session[:user_id])
  end

  def new #ユーザー新規登録画面を表示する。
    @user_new = User.new
  end

  def create #ユーザー新規登録画面のフォームから新規登録できるようにする。
    @user_new = User.new(user_params)
    if @user_new.save
      session[:user_id] = @user_new.id #ログイン状態にする
      flash[:notice] = "新規登録しました。"
      redirect_to memos_path
    else
      flash.now[:alert] = "登録に失敗しました。"
      render action: "new"
    end
  end

  def edit #ユーザー詳細情報のemailや名前を変更できるようにする。
    @user = User.find(session[:user_id])
  end

  def update #ユーザー詳細情報のemailや名前を変更した後に更新できるようにする。
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      redirect_to myInfo_path
      flash[:notice] = "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "登録に失敗しました。"
      render action: "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
