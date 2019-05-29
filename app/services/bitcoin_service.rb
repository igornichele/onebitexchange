require 'rest-client'
require 'json'
 
class BitcoinService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f

    if @source_currency == "BTC"
        @to_btc = false
    else
        @to_btc = true
    end
  end
 
 
  def perform
    begin
        bit_api_url = Rails.application.credentials[Rails.env.to_sym][:bit_api_url]
        if @to_btc
            url = "#{bit_api_url}tobtc?currency=#{@source_currency}&value=#{@amount.to_f.round(0)}"
        else
            url = "#{bit_api_url}frombtc?currency=#{@target_currency}&value=#{@amount.to_f.round(0)}"
        end
        byebug
        res = RestClient.get url
        value = JSON.parse(res.body).to_f
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end