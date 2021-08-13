class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]
    before_action :check_owner, only: %i[update destroy]

    # GET /users/1
    def show
        # render json: User.find(params[:id])
        render json: UserSerializer.new(@user).serializable_hash
    end

    # POST /users
    def create
        @user = User.new(user_params)

        if @user.save
            # render json: @user, status: :created
            render json: UserSerializer.new(@user).serializable_hash, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /users/1
    def update
        if @user.update(user_params)
            # render json: @user, status: :ok
            render json: UserSerializer.new(@user).serializable_hash, status: :ok
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    # DELETE /users/1
    def destroy
        @user.destroy
        head 204
    end

    private
    # Only allow a trusted parameter 'white list' through.
    def user_params
        params.require(:user).permit(:email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def check_owner
        head :forbidden unless @user.id == current_user&.id
    end
end
