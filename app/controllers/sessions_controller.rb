class SessionsController < ApplicationController

  before_action :logged_in?, only: [:new, :create] #onlyでnewとcreateが実行された時にのみlogged_in?を発火させる。

  def create
    # フォームから渡ってきた値「emailカラム」と「passwordカラム」が、
    # データベース内の「emailカラム」と「passwordカラム」が一致した場合@userに格納する。
    # 一致するユーザーが見つからなかった場合、@userは nilになる。
    @user = User.find_by(email: params[:email], password: params[:password]) #paramsにはフロントから送られてくる値が入っている。
    if @user
      session[:user_id] = @user.id #user.idとはデータベースに保存するとrailsが勝手に割り振ってくれる。sessionメソッドとはjsのlocalstrageのようなもので、サーバーで情報を保管できるようにしたもの。ブラウザにはセッションIDのみが保存さる。「user_id」という名前でサーバー側のセッションストレージに保存される。
      flash[:notice] = "ログインに成功しました。"
      redirect_to memos_path
    else
      flash.now[:alert] = "ログインに失敗しました。"
      render action: "new"
    end
  end

  # セッションを無効化する。
  def destroy
    session[:user_id] = nil
    redirect_to login_path #ログイン画面に戻る。
  end
end
