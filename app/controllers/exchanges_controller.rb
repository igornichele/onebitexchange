class ExchangesController < ApplicationController
  def index
  end

  def convert
    if params[:taget_currency] == 'BTC' or params[:source_currency] == 'BTC'
      value = BitcoinService.new(params[:source_currency], params[:target_currency], params[:amount]).perform
      render json: {"value": value}
    else
      value = ExchangeService.new(params[:source_currency], params[:target_currency], params[:amount]).perform
      render json: {"value": value}
    end
  end
end
