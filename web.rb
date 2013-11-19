require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/reloader' if development?
require 'json'

config_file './config.yml'

get '/' do
  redirect '/index.html'
end

get '/schedule_details.?:format?' do
  if params[:date]
    the_date = Date.parse(params[:date])
  else
    the_date = Date.today
  end

  date_key = the_date.strftime('d_%Y_%m_%d')
  day_code = settings.send(date_key)

  if params[:format] == 'json'
    content_type :json

    if day_code == 'A'
      { :code => 'A', :periods => [ 'Period 1', 'Period 3', 'Period 5', 'Period 7' ] }.to_json
    elsif day_code == 'B'
      { :code => 'B', :periods => [ 'Period 2', 'Period 4', 'Period 6', 'Period 8' ] }.to_json
    elsif day_code == 'F'
      { :code => 'F', :description => 'Finals' }.to_json
    elsif day_code == 'P'
      { :code => 'P', :description => 'Planning' }.to_json
    elsif day_code == 'W'
      { :code => 'W', :description => 'Weekend' }.to_json
    elsif day_code == 'H'
      { :code => 'H', :description => 'Holiday' }.to_json
    end
  else
    if day_code == 'A'
      '<h1>A</h1><p>Period 1</p><p>Period 3</p><p>Period 5</p><p>Period 7</p>'
    elsif day_code == 'B'
      '<h1>B</h1><p>Period 2</p><p>Period 4</p><p>Period 6</p><p>Period 8</p>'
    elsif day_code == 'F'
      '<h1>F</h1><p>Finals</p>'
    elsif day_code == 'W'
      '<h1>P</h1><p>Planning</p>'
    elsif day_code == 'W'
      '<h1>W</h1><p>Weekend</p>'
    elsif day_code == 'H'
      '<h1>H</h1><p>Holiday</p>'
    end
  end
end