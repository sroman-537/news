require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "0adf9455fa4ccdbcd3cd91b7814d2cbe"

forecast = ForecastIO.forecast(42.0574063,-87.6722787).to_hash

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=05420b4bdf204018b81ef80b92aa3e2a"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

get "/" do
  view "geocode"
       end

get "/news" do
  results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    lat= "#{lat_long[0]}"
    long= "#{lat_long[1]}"  
    forecast = ForecastIO.forecast("#{lat}","#{long}").to_hash
    @current_temperature = forecast["currently"]["temperature"]
    @conditions = forecast["currently"]["summary"]
    @forecast = forecast["daily"]["data"] 
    for day in forecast["daily"]["data"]

puts "A high temperature of #{day["temperatureHigh"]} and #{day["summary"]}."
    end

    for article in news["article"]["headline"]

puts "Check out #{article["headline"]}"
    end
  
view "ask"
end