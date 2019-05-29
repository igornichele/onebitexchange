class ExchangesController < ApplicationController
  def index
  end

  def convert
    if params[:target_currency] == "BTC" or params[:source_currency] == "BTC"
      value = BitcoinService.new(params[:source_currency], params[:target_currency], params[:amount]).perform
    else
      value = ExchangeService.new(params[:source_currency], params[:target_currency], params[:amount]).perform
    end

    render json: {"value": value}
  end
end
