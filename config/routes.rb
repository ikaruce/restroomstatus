Rails.application.routes.draw do
  get "status" => "restroom#status"
  
  root "restroom#show"
end
