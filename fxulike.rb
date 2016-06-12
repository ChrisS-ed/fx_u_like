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
			puts "NO DATE ENTERED"
			@error = "Invalid date entered"
			halt erb(:home)
	end

  	@amount = params[:amount].to_f
  	if (!@amount.is_a?(Numeric)) || @amount<=0
  		puts "INVALID AMOUNT ENTERED"
  		@error = "Invalid amount entered"
		halt erb(:home)
  	end

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

  	@conversion_rate = ExchangeRate.at(@date, @base_currency, @counter_currency)

  	puts "********************************************"
  	print "RETURNED CONVERSION RATE: "
  	puts @conversion_rate
  	puts "********************************************"

  	if @conversion_rate.is_a?(String)
  		@error = @conversion_rate
  	else
  		@result = @conversion_rate * @amount
  	end

  	erb :home
end