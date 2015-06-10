require 'sinatra'
require 'json'

birthdates = {
'Paolo'=>'March 2, 2009',
'Stefano'=>'May 22, 2007',
'Veronica'=>'June 24, 1973',
'Roberto'=>'April 30, 1959' }


use Rack::Auth::Basic,"Protected Area" do |username, password|
  username=='roberto' and password=='texas'
end

get '/' do
    user = request.env["REMOTE_USER"]
      "Hello, #{user}"
end


# search a record
get '/FamilyMembers/:name' do
  res=birthdates[params[:name]]
  return status 404 if res.nil?
  res
end

# list all records
get '/FamilyMembers' do
  birthdates.to_json 
end

# add a new record
post '/FamilyMembers' do
  res=birthdates[params['name']]
  return status 409 if !res.nil?
  birthdates[params['name']]=params['dob']
  status 201
end

# delete a record
delete '/FamilyMembers/:name' do
  res=birthdates[params[:name]]
  return status 404 if res.nil?
  birthdates.delete(params[:name])
  status 202
end

# update a record
put '/FamilyMembers/:name' do
  res=birthdates[params[:name]]
  return status 404 if res.nil?
  birthdates[params[:name]]=params[:dob]
  status 202
end

