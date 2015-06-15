class WelcomeController < ApplicationController
  def index
    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND
SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA
FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC)
      @states.sort!

if params[:city] != nil
  if params[:city] != ""
    if params[:city].include?(" ")
      params[:city].gsub! " ", "_"
    end

if params[:state] == ""
   url = "http://api.wunderground.com/api/b11a9b0d7ef8ccd2/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json"

else
url = "http://api.wunderground.com/api/b11a9b0d7ef8ccd2/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json"
end

open(url) do |f|
    json_string = f.read
    parsed_json = JSON.parse(json_string)
    @location = parsed_json['location']['city']
    @temp_f = parsed_json['current_observation']['temp_f']
    @temp_c = parsed_json['current_observation']['temp_c']
    @weather_icon = parsed_json['current_observation']['icon_url']
    @in_words = parsed_json['current_observation']['weather']
    @forecast_link = parsed_json['current_observation']['forecast_url']
    @real_feel = parsed_json['current_observation']['feelslike_f']
    end
  end
 
elsif params[:city] == "" && params[:button_pushed] == true
  redirect_to find_weather_path
end

  def test
    
  response = HTTParty.get("http://api.wunderground.com/api/b11a9b0d7ef8ccd2//geolookup/conditions/q/TX/Dallas.json")
  
  @location = response['location']['city']
  @temp_f = response['current_observation']['temp_f']
  @temp_c = response['current_observation']['temp_c']
  @weather_icon = response['current_observation']['icon_url']
  @weather_words = response['current_observation']['weather'] 
  @forecast_link = response['current_observation']['forecast_url']
  @real_feel = response['current_observation']['feelslike_f']
  end
  end


  
          
end
