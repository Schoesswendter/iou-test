# app/controllers/api/v1/users_controller.rb
 
class Api::V1::UsersController < Api::V1::BaseController
    def index
      users = User.all
   
      render json: UserSerializer.new(users).serialized_json
    end
   
    def show
      user = User.find(params[:id])
   
      render json: UserSerializer.new(user).serialized_json
    end

    def create
        @user = User.new(user_params)

        respond_to do |format|
            if @user.save
                render json: UserSerializer.new(@user).serialized_json, status: 201
            else
                render json: { errors: ErrorSerializer.new(@user).serialized_json }, status: 422
            end
        end
    end

    def user_params
        p = params.require(:data).permit(:type, attributes: %i[name email password])
        
        if p[:type] == 'user'
           p[:attributes] 
        else
          nil
        end
    end    
  end