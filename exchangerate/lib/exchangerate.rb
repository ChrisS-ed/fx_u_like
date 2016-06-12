# require "exchangerate/version"
require 'nokogiri'
require 'open-uri'

module ExchangeRate

    # load XML data once from EBC website (this will eventually be done by cron job) 
    xml_data = open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml').read
    puts "*** DOWNLOADING ECB DATA ***"
    puts
    RATES_DATA = Nokogiri::XML(xml_data)

	def self.at(date, base_currency, counter_currency)

    	# look for date in xml file

        if RATES_DATA.css("[time='#{date.to_s}']").empty? 
            @error = "Date Not Found"
            return @error
        end
        rates_for_date = RATES_DATA.css("[time='#{date.to_s}']").children

    	# fetch base and counter rates for that date

        if base_currency == "EUR"
            base_rate = 1.00
        else
            base_rate_fragment = rates_for_date.css("[currency='#{base_currency}']")
            base_rate = base_rate_fragment.attribute('rate').value.to_f
        end

        if counter_currency == "EUR"
            counter_rate = 1.00
        else
            counter_rate_fragment = rates_for_date.css("[currency='#{counter_currency}']")
            counter_rate = counter_rate_fragment.attribute('rate').value.to_f
        end

        # calculate and return overall exchange rate

        @conversion_rate = (1/base_rate) * counter_rate
        return @conversion_rate

  	end

end
