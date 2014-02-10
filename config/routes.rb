MadisonLiveNew::Application.routes.draw do

  # Visiting the root of the site should redirect to the index.html static page.
  get '/', :to => redirect('/index.html')

  # Requests for schedules are directed to the schedules controller and can get html or json.
  get '/schedules(/:date)(.:format)' => 'schedules#show'

end
