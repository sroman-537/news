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

get "/" do
  view "geocode"
end

get "/map" do
    results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    "#{lat_long[0]} #{lat_long[1]}"
end

for day in forecast["daily"]["data"]
  puts "A high temperature of #{day["temperatureHigh"]} and #{day["summary"]}."
end


get "/news" do
  # do everything else
end