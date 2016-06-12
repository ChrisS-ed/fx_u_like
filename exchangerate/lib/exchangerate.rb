# require "exchangerate/version"
require 'nokogiri'
require 'open-uri'

module ExchangeRate

    xml_data = open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml').read
    puts "*** DOWNLOADING ECB DATA ***"
    puts
    RATES_DATA = Nokogiri::XML(xml_data)

	def self.at(date, base_currency, counter_currency)

        puts "---------------------------------------------------------------"
        print "EXCHANGERATE DATE: "
        puts date
        print "EXCHANGERATE BASE: "
        puts base_currency
        print "EXCHANGERATE COUNTER: "
        puts counter_currency
        puts "---------------------------------------------------------------"

    	# look for date in xml file

        puts "*** RATES FOR DATES: ***"
        if RATES_DATA.css("[time='#{date.to_s}']").empty? 
            puts "EMPTY DATA"
            # raise "Date Not Found Error"
            @error = "Date Not Found"
            return @error
        end
        puts RATES_DATA.css("[time='#{date.to_s}']")

    	rates_for_date = RATES_DATA.css("[time='#{date.to_s}']").children
        print "RATES: "
    	puts rates_for_date
        puts
        
        # raise DateNotFoundError if RATES_DATA.css("[time='#{date.to_s}']").children.empty?

    	# fetch base and counter rates for that date

        base_rate_fragment = rates_for_date.css("[currency='#{base_currency}']")
        print "BASE RATE FRAGMENT"
        puts base_rate_fragment
        puts
        base_rate = base_rate_fragment.attribute('rate').value.to_f
        print "BASE RATE:"
        puts base_rate
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
