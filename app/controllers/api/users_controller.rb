module Api
  class UsersController < BaseController
    def index
      users = User.where.not(id: current_user.id)
                  .where("username ILIKE ?", "%#{params[:search]}%")
      render json: users.map { |u| user_json(u) }
    end

    def me
      render json: user_json(current_user)
    end

    def show
      user = User.find(params[:id])
      render json: user_json(user)
    end

    def update
      if current_user.update(user_params)
        render json: user_json(current_user)
      else
        render json: { errors: current_user.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:username, :bio, :avatar)
    end

    def user_json(user)
      {
        id: user.id,
        username: user.username,
        bio: user.bio,
        avatar_url: user.avatar.attached? ? url_for(user.avatar) : nil
      }
    end
  end
end
