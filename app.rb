require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "0adf9455fa4ccdbcd3cd91b7814d2cbe"

get "/" do
  # show a view that asks for the location
end

get "/news" do
  # do everything else
end