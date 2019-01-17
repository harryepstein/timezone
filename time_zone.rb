require 'json'
require 'Geocoder'
require 'net/http'
require 'dotenv'
# require 'tk'
require 'pp'
require "pry"
# require 'pry-byebug'
# require 'pry-debugger'
require 'pry-nav'
require 'pry-stack_explorer'
require 'nokogiri'

@@api = ENV['API']
# require 'pry-rescue'
# require 'pry-stack_explorer'
# require 'pry-byebug'
class TimeZone
  @@api = ENV['API']
  # because why not, I've never seen these before
  puts "all the cool dollar values:", $*
  puts $!,
  $@,
  $_,
  $.,
  $&,
  $~,
  $n,
  $~,
  $=,
  $/,
  $\,
  $0,
  $*,
  $$,
  $?
  
  
  def initialize
  # globals
  Dotenv.load("./enviro.env")
  @api = ENV['API']
  @which_city = ''
  @lat = lat
  @lon = lon
  $api = @api

  # Let's see what happens with autosave on and the run on save command active. 
  # It looks like it just runs the command over and over
  $CURRENT_TIME_HERE = Time.now
  puts "the time is: #{$CURRENT_TIME_HERE}"
  end

attr_reader :lat
attr_reader :lon
attr_reader :api
# display currently saved favorite cities and their time zones, i.e. India, Washington, D.C., and California
# to that end, at the prompt, user can input either City or Country for timezone, which is converted into correct time zone
# get input, ask the city they want the timezone of

  def city_input
    puts 'Which city?'
    @which_city = gets.chomp
  end

# this is still just a test of the SaveAndRun settings
# convert input to appropriate time zone
  def input_to_latlong(which_city)
    # make a call api to get long/lat for requested city
    results = Geocoder.search(@which_city)
    @lat = results[0].data['lat']#the secret was that the index was needed to further access the data members
    @lon = results[0].data['lon']
    puts "The results are: #{lat} #{lon}"
    [@lat, @lon]
    # lat = results['lat']
    # long = results['lon']
    # return lat, long
    # make call to api to get time zone of long/lat

    # return timezone from returned time
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
  end
end

a_tz = TimeZone.new
binding.pry

a_tz.city_input()
a_tz.input_to_latlong(@which_city)

a_tz.latlong_to_timezone(lat: @lat, lon: @lon, api: $api)