$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'pp'

# Initialize the client.
client = Google::APIClient.new(
  :application_name => 'Drive API Ruby Demo',
  :application_version => '0.0.1'
)

# Initialize Google Drive REST API. Note this will make a request to the
# discovery service every time, so be sure to use serialization
# in your production code. Check the samples for more details.
drive = client.discovered_api('drive','v2')

# Load client secrets from your client_secrets.json.
client_secrets = Google::APIClient::ClientSecrets.load

# Run installed application flow. Check the samples for a more
# complete example that saves the credentials between runs.
flow = Google::APIClient::InstalledAppFlow.new(
  :client_id => client_secrets.client_id,
  :client_secret => client_secrets.client_secret,
  :scope => ['https://www.googleapis.com/auth/drive']
)
client.authorization = flow.authorize
parameters={}
# Make an API call.
result = client.execute(
  :api_method => drive.files.list,
  :parameters => parameters
)
puts result.data["items"][0]["title"]
puts result.data["items"][1]["title"]
puts result.data["items"].size
