require 'sinatra'
require 'json'

birthdates = {
'Paolo'=>'March 2, 2009',
'Stefano'=>'May 22, 2007',
'Veronica'=>'June 24, 1973',
'Roberto'=>'April 30, 1959' }

#search
get '/FamilyMembers/:name' do
  res=birthdates[params[:name]]
  return status 404 if res.nil?
  res
end

#list
get '/FamilyMembers' do
  birthdates.to_json 
end

#add
post '/FamilyMembers' do
  res=birthdates[params['name']]
  return status 409 if !res.nil?
  birthdates[params['name']]=params['dob']
  status 201
end
