class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:format])
    current_user.follow(user)
    redirect_back(fallback_location: users_path)
  end

  def destroy
    user = Relationship.where(followed_id: params[:id])
    current_user.unfollow(user)
    redirect_back(fallback_location: users_path)
  end
end
