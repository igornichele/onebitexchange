require 'rest-client'
require 'json'
 
class BitcoinService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f

    if source_currency == "BTC"
        @to_btc = true
    else
        @to_btc = false
    end
  end
 
 
  def perform
    begin
        bit_api_url = Rails.application.credentials[Rails.env.to_sym][:bit_api_url]
        if @to_btc
            url = "#{bit_api_url}tobtc?currency=#{@target_currency}&value=#{@amount}"
        else
            url = "#{bit_api_url}frombtc?currency=#{@source_currency}&value=#{@amount}"
        end
        res = RestClient.get url
        value = JSON.parse(res.body).to_f
        
        value   
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end