class MicropostsController < ApplicationController
    # ログインしていない場合は/loginにリダイレクト
    before_action :logged_in_user, onky: [:create]
    
    def create
        # 現在のユーザーに紐付いたMicropostのインスタンスを作成し変数へ代入
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost create!"
            redirect_to root_url
        else  
            @feed_items = current_user.feed_items.include(:user).order(created_at: :desc)
            render 'static_pages/home'
        end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end
    
    private
    # 受け取ったパラメーターのparams[:micropost]のうち、
    # params[:micropost][:content]のみ取り出す
    def micropost_params
        params.require(:micropost).permit(:content)
    end
end
