require 'sinatra'
require 'sinatra/contrib/all' if development?

get '/'  do
	erb :home
end
	
get '/convert' do
	@date = Date.parse(params[:date])
  	@amount = params[:amount].to_f
  	@base_currency = params[:base_currency]
  	@counter_currency = params[:counter_currency]

  	puts "---------------------------------------------------------------"
	print "@DATE: "
	puts @date
	print "@AMOUNT: "
	puts @amount
	print "@BASE: "
	puts @base_currency
	print "@COUNTER: "
	puts @counter_currency
	puts "---------------------------------------------------------------"

  	# @conversion_rate = ExchangeRate.at(@date, @base_currency, @counter_currency)
  	# @result = @conversion_rate * @amount

  	erb :home
end