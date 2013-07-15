class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@pins = @user.pins.page(params[:page]).per_page(20)
  end


 def mypage
  	@user = current_user
  	@pins = @user.pins.page(params[:page]).per_page(20)
  end
end

