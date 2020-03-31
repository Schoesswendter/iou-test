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
        @user = User.new(register_user_params)

        respond_to do |format|
            if @user.save
                render json: UserSerializer.new(@user).serialized_json, status: 201
            else
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def register_user_params
        p = params.require(:data).permit(:type, attributes: %i[name email password])
        
        if p[:type] == 'user'
           p[:attributes] 
        else
          nil
        end
    end    
  end