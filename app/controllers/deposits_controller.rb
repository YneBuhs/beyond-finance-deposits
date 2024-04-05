class DepositsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
    def index
      tradeline = get_tradeline  
      deposits = Deposit.find_deposits_for_tradeline(tradeline)
      render json: deposits, each_serializer: DepositSerializer
    end

    def create 
      tradeline = get_tradeline
      deposit = Deposit.create_deposit(deposit_params.merge(tradeline: tradeline))
      render json: deposit, status: :created, serializer: DepositSerializer
    end
  
    def show
      tradeline = get_tradeline
      deposit = Deposit.find_deposit(id: params[:id], tradeline_id: tradeline)
      render json: deposit, serializer: DepositSerializer
    end
  
    private
  
    def get_tradeline
        params.require(:tradeline_id)
    end

    def get_deposit_params
      params.require(:deposit).permit(:date, :amount)
    end

    def not_found
      render json: 'not_found', status: :not_found
    end
end
  