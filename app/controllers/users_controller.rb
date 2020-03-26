# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(register_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user.destroy
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User not found.' }
        format.json { render json: { "error": 'User not found' }, status: :not_found }
      end
      return
    rescue ActiveRecord::InvalidForeignKey
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User cannot be deleted.' }
        format.json { render json: { "error": 'User cannot be deleted' }, status: :forbidden }
      end
      return
    rescue StandardError
      raise
    rescue Exception
      raise
    end

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :name)
  end

  def register_user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end


  # app/controllers/users_controller.rb
  def update
    set_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # app/controllers/api/v1/users_controller.rb
  def update
    set_user
    if @user.update(user_params)
      render status: :ok, json: UserSerializer.new(@user).serializable_hash.to_json
    else
      render json: @user.errors, status: 422  # einfacher error
      # render_api_error(@user.errors, 422)   # richtiger json-api error, muss man selber implementieren
    end
  end

    # Parse JSON-Api data:
  # {"data"=>{"type"=>"user",
  #           "attributes"=>{"name"=>"Good", "email"=>"good@hier.com", "password"=>"[FILTERED]"}}
  def user_params
    p = params.require(:data).permit(:type, attributes: %i[name email password])
    
    if p[:type] == 'user'
       p[:attributes] 
    else
      nil
    end
  end

