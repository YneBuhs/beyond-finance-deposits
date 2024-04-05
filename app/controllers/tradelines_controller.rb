class TradelinesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: Tradeline.all, each_serializer: TradelineSerializer
  end

  def show
    render json: Tradeline.find(params[:id]), serializer: TradelineSerializer
  end

  private

  def not_found
    render json: 'not_found', status: :not_found
  end
end
