# require "exchangerate/version"
require 'nokogiri'
require 'open-uri'

module ExchangeRate
  
	def self.at(date, base_currency, counter_currency)

        puts "---------------------------------------------------------------"
        print "EXCHANGERATE DATE: "
        puts date
        print "EXCHANGERATE BASE: "
        puts base_currency
        print "EXCHANGERATE COUNTER: "
        puts counter_currency
        puts "---------------------------------------------------------------"

		xml_data = open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml').read
		rates_data = Nokogiri::XML(xml_data)

    	# look for date in xml file

    	rates_for_date = rates_data.css("[time='#{date.to_s}']").children
    	print "RATES"
    	print rates_for_date

    	# fetch base and counter rates for that date

        base_rate_fragment = rates_for_date.css("[currency='#{base_currency}']")
        print "BASE RATE FRAGMENT"
        print base_rate_fragment
        puts
        base_rate = base_rate_fragment.attribute('rate').value.to_f
        print "BASE RATE:"
        print base_rate
        puts

        counter_rate_fragment = rates_for_date.css("[currency='#{counter_currency}']")
        print "COUNTER RATE FRAGMENT"
        print counter_rate_fragment
        puts
        counter_rate = counter_rate_fragment.attribute('rate').value.to_f
        print "COUNTER RATE:"
        print counter_rate
        puts

        # calculate and return overall exchange rate

        @conversion_rate = (1/base_rate) * counter_rate
        print "CONVERSION RATE:"
        print @conversion_rate
        puts
        return @conversion_rate

  	end

end
