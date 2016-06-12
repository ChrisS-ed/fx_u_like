require 'sinatra'
require 'sinatra/contrib/all' if development?
require_relative './exchangerate/lib/exchangerate'

get '/'  do
	erb :home
end
	
get '/convert' do
	
	begin
		@date = Date.parse(params[:date])
		rescue ArgumentError
			@error = "Invalid date entered"
			halt erb(:home)
	end

  	@amount = params[:amount].to_f
  	if (!@amount.is_a?(Numeric)) || @amount<=0
  		@error = "Invalid amount entered"
		halt erb(:home)
  	end

  	@base_currency = params[:base_currency]
  	@counter_currency = params[:counter_currency]
  	@conversion_rate = ExchangeRate.at(@date, @base_currency, @counter_currency)

  	if @conversion_rate.is_a?(String)
  		@error = @conversion_rate
  	else
  		@result = @conversion_rate * @amount
  	end

  	erb :home
end