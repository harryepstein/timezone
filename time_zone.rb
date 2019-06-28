require 'json'
require 'Geocoder'
require 'net/http'
require 'dotenv'
require 'pp'
require 'pry'
require 'pry-nav'
require 'nokogiri'
# require 'tk'
# require 'pry-byebug'
# require 'pry-debugger'
# require 'pry-stack_explorer'
# require 'pry-rescue'
# require 'pry-stack_explorer'
# require 'pry-byebug'

$api = ENV['API']
def loadsaved()
  f = File.open('timezones.tzb','r')
  fz = f.readlines 
  fz.each  {|timez|
    puts "In #{@which_city} it is #{latlong_to_timezone(@timezone)}"
  }

end

class TimeZone
  
attr_reader :lat
attr_reader :lon
attr_reader :api

  def initialize
  # globals and instances
  Dotenv.load("./enviro.env")
  @which_city = ''
  @lat = lat
  @lon = lon

  # Let's see what happens with autosave on and the run on save command active. 
  # It looks like it just runs the command over and over
  $CURRENT_TIME_HERE = Time.now
  puts "the time is: #{$CURRENT_TIME_HERE}"
  end


# display currently saved favorite cities and their time zones, i.e. India, Washington, D.C., and California
# to that end, at the prompt, user can input either City or Country for timezone, which is converted into correct time zone
# get input, ask the city they want the timezone of

  def get_city_input
    puts 'Which city?'
    @which_city = gets.chomp
  end


  def convert_input_to_latlong()
    # make a call api to get long/lat for requested city
    results = Geocoder.search(@which_city)
    @lat = results[0].data['lat']#the secret was that the index was needed to further access the data members
    @lon = results[0].data['lon']
    pp results
    puts "The results are: #{lat} #{lon}"
    [@lat, @lon]
    
  end

  def latlong_to_timezone(lat:, lon:, api:)
    # make call to google maps for timezone from latlong
    # SAMPLE  QUERY http://api.timezonedb.com/v2.1/get-time-zone?key=YOUR_API_KEY&format=xml&by=zone&zone=America/Chicago  # 
    query = URI.parse("http://api.timezonedb.com/v2.1/get-time-zone?key=#{@api}&format=xml&by=position&lat=#{@lat}&lng=#{@lon}")
    
    req = Net::HTTP::Get.new(query.to_s)
    res = Net::HTTP.start(query.host, query.port) {|http|
      http.request(req)
    }
    parsed_response = Nokogiri::XML.parse(res.body)
    puts @timezone
  end

  def convert_tz_to_local(timezone)

      converted_current_time 
      puts "In "
  end
end

a_tz = TimeZone.new
# binding.pry

# timehere()
loadsaved()
# startloop()

# a_tz.get_city_input()
# a_tz.convert_input_to_latlong()

# a_tz.latlong_to_timezone(lat: @lat, lon: @lon, api: $api) 