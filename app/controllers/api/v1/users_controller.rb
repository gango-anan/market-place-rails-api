class Api::V1::UsersController < ApplicationController
    # GET /users/1
    def show
        render json: User.find(params[:id])
    end

end
