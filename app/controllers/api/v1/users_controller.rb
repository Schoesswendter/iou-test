# app/controllers/api/v1/users_controller.rb
 
class Api::V1::UsersController < Api::V1::BaseController
    before_action :set_user, only: %i[show update destroy]
    before_action :user_params, only: %i[create]

    def index
      users = User.all
   
      render json: UserSerializer.new(users).serialized_json
    end
   
    def show
      render json: UserSerializer.new(@user).serialized_json
    end

    def update
        set_user
        if @user.update(user_params)
        render status: :ok, json: UserSerializer.new(@user).serializable_hash.to_json
        else
        render json: @user.errors, status: 422  # einfacher error
        # render_api_error(@user.errors, 422)   # richtiger json-api error, muss man selber implementieren
        end
    end

    def destroy
    end

    def set_user
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)

        if @user.save
            render status: 201, json: UserSerializer.new(@user).serializable_hash.to_json
        else
            render json: @user.errors, status: 422
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