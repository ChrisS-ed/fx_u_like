require "exchangerate/version"

module ExchangeRate
  
	def self.at(date, base_currency, counter_currency)

		xml_data = open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml').read
		rates_data = Nokogiri::XML(xml_data)

    	# for given date: get base_currency exchange rate and counter_currency exchange rate, then return exchange rate

    	# look for date in xml file
    	rates_for_date = rates_data.css("[time='#{date.to_s}']").children
    	print "RATES"
    	print rates_for_date

    	# fetch base and counter rates for that date
    	base_rate = rates_for_date.css("[currency='#{base_currency}']")
    	print "BASE RATE"
    	print base_rate

    	counter_rate = rates_for_date.css("[currency='#{counter_currency}']")
    	print "COUNTER RATE"
    	print counter_rate

    	# calculate and return overall exchange rate

  	end

end
