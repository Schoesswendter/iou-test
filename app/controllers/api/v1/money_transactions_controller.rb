# frozen_string_literal: true

class Api::V1::MoneyTransactionsController < Api::V1::BaseController
    before_action :set_money_transaction, only: %i[show edit update destroy]
  
    def index
      money_transactions = MoneyTransaction.all
  
      render json: MoneyTransactionSerializer.new(money_transactions).serialized_json, status: :ok
    end
  
    def show
      render json: MoneyTransactionSerializer.new(@money_transaction).serialized_json, status: :ok
    end
  
    def create
      @money_transaction = MoneyTransaction.new(money_transaction_params)
      if @money_transaction.save
        render status: 201, json: MoneyTransactionSerializer.new(@money_transaction).serializable_hash.to_json
      else
        render json: @money_transaction.errors, status: 422
      end
    end
  
    def update
      if @money_transaction.update(money_transaction_params)
        render status: :ok, json: MoneyTransactionSerializer.new(@money_transaction).serializable_hash.to_json
      else
        render json: @money_transaction.errors, status: 422 # einfacher error
      end
    end
  
    def destroy
      begin
        @money_transaction.destroy
      rescue ActiveRecord::RecordNotFound
        render json: @money_transaction.errors, status: :not_found  # einfacher error
        return
      rescue ActiveRecord::InvalidForeignKey
        render json: @money_transaction.errors, status: :forbidden  # einfacher error
        return
      rescue StandardError
        raise
      rescue Exception
        raise
      end
      render json: :no_content, status: 204
    end
  
    private
  
    def set_money_transaction
      @money_transaction = MoneyTransaction.find(params[:id])
    end
  
    def money_transaction_params
      p = params.require(:data).permit(:type, attributes: %i[amount paid_at], relationships: %i[creditor_id debitor_id])
      p[:attributes].merge(p[:relationships]) if p[:type] == 'money_transaction'
    end
  end
  