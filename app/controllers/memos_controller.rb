class MemosController < ApplicationController

  before_action :current_user #認証されているかを先にチェックする。
  
  def index
    @memo_new = Memo.new #モデルMemoのインスタンスを用意して「@memo_new」に格納する。
    @memos = current_user.memos #current_userとは現在ログインしている自分自身に当たる。memosとはリレーション設定した際のデータ名。自分自身のmemosを取得する。
  end

  def create
    @memo_new = Memo.new(memo_params) #プライベートメソッド「memos_params」を受け取り代入する。
    @memo_new.user_id = current_user.id #memo_new.user_idの中に代入する。
    @memos = current_user.memos

    if @memo_new.save #「save」で保存する。
      flash[:notice] = "メモの保存に成功しました。"
      redirect_to root_path # トップにリダイレクトさせる。
    else
      flash.now[:alert] = "メモの保存に失敗しました。"
      render :index, status: :unprocessable_entity #失敗した場合indexアクションを起こす。
    end
  end

  def update
    @memo = Memo.find(params[:id]) #指定したものに対してupdateを実行する。
    @memo.update(memo_params)# 更新する内容はmemo_paramsのtilteとdescription。
    redirect_to root_path # トップにリダイレクトさせる。
  end

  def destroy
    @memo = Memo.find(params[:id]) #指定したものに対してdestroyを実行する。
    @memo.destroy
    redirect_to root_path # トップにリダイレクトさせる。
  end

  def search
    search_word = params[:word] #ターミナルでStarted GET "/search?word=&commit=%E6%A4%9C%E7%Bが確認できる。
    @memo_new = Memo.new
    @memos = current_user.memos.where("title LIKE ? or description LIKE ?", "%#{search_word}%", "%#{search_word}%") #LIKEとすることで曖昧な検索になる。%#{search_word}%、%で囲むことでparamsのワードが部分的に一致したものをデータベースから取得する。
    if @memos.count > 0
      flash.now[:notice] = "#{@memos.count}件のメモが見つかりました。" #一度のレンダリングでメッセージデータは消えて欲しいのでflash.nowを指定する。
      render :index #レンダリングする。
    else
      flash.now[:alert] =  "メモが見つかりませんでした。" #一度のレンダリングでメッセージデータは消えて欲しいのでflash.nowを指定する。
      render :index #レンダリングする。
    end
  end

  private
  def memo_params
    params.require(:memo).permit(:title, :description, :user_id)
  end


end
