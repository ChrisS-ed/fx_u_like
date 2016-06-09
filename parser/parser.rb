require 'nokogiri'
require 'open-uri'

xml_data = open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml').read
rates_data = Nokogiri::XML(xml_data)



test_date = Date.new(2016, 6, 8)
base_currency = "USD"
counter_currency = "GBP"


rates_for_date = rates_data.css("[time='#{test_date.to_s}']").children
print rates_for_date
puts

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