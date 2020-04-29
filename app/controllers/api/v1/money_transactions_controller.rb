# frozen_string_literal: true

class MoneyTransactionsController < Api::V1::BaseController
    before_action :set_money_transaction, only: %i[show edit update destroy]
  
    # GET /money_transactions
    # GET /money_transactions.json
    def index
      money_transactions = MoneyTransaction.all
      
      render json: UserSerializer.new(money_transactions).serialized_json
    end
  
    # GET /money_transactions/1
    # GET /money_transactions/1.json
    def show
      render json: UserSerializer.new(@money_transaction).serialized_json
    end
  
    # GET /money_transactions/new
    def new
      @money_transaction = MoneyTransaction.new
    end
  
    # GET /money_transactions/1/edit
    def edit; end
  
    # POST /money_transactions
    # POST /money_transactions.json
    def create
        @money_transaction = MoneyTransaction.new(money_transaction_params)
  
        if @money_transaction.save
            render status: 201, json: MoneyTransactionSerializer.new(@money_transaction).serializable_hash.to_json
        #   format.html { redirect_to money_transactions_path, notice: 'Money transaction was successfully created.' }
        #   format.json { render :show, status: :created, location: @money_transaction }
        else
        #   format.html { render :new }
        #   format.json { render json: @money_transaction.errors, status: :unprocessable_entity }
            render json: @money_transaction.errors, status: 422
        end
    end
  
    # PATCH/PUT /money_transactions/1
    # PATCH/PUT /money_transactions/1.json
    def update
      respond_to do |format|
        Rails.logger.warn(money_transaction_params)
        if @money_transaction.update(money_transaction_params)
          format.html { redirect_to money_transactions_path, notice: 'Money transaction was successfully updated.' }
          format.json { render :show, status: :ok, location: @money_transaction }
        else
          Rails.logger.warn(@money_transaction.errors.to_json)
  
          format.html { render :edit }
          format.json { render json: @money_transaction.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /money_transactions/1
    # DELETE /money_transactions/1.json
    def destroy
      @money_transaction.destroy
      respond_to do |format|
        format.html { redirect_to money_transactions_url, notice: 'Money transaction was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
  
    def set_money_transaction
      @money_transaction = MoneyTransaction.find(params[:id])
    end
  
    def money_transaction_params
      params.require(:money_transaction).permit(:creditor_id, :debitor_id, :amount, :paid_at)
    end
  end
  