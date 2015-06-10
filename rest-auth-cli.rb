require 'net/http'  # standard ruby library
require 'json'      # gem install json
require 'highline/import' # gem install highline

# ansi escape sequences
# from http://bluesock.org/~willkg/dev/ansi.html#sequences
BLUE_BOLD = "\e[34;1m"
GREEN = "\e[32m"
NORMAL = "\e[0m"
RED = "\e[31m"
CLEAR_SCREEN = "\e[2J"

# server
baseurl='http://localhost:4567'
url=baseurl+'/FamilyMembers'

# fancy colorized commands menu
cmds='search list add update delete quit'.split(' ')
cmds.each {|w| w.sub!(/([a-z])/,BLUE_BOLD+'\1'+NORMAL)}
menu=cmds.join(' ')

# enclose in begin/end to trap exceptions
begin
  print CLEAR_SCREEN
  # authorize
  username = ask("Enter your username:  ") { |q| q.echo = true }
  password = ask("Enter your password:  ") { |q| q.echo = "*" }
  uri=URI.parse(baseurl)
  # HTTP session stays open until the end of the block 
  Net::HTTP.start(uri.hostname, uri.port) do |http|    
    reqs=Net::HTTP::Get.new(uri)
    reqs.basic_auth username, password
    resp=http.request(reqs)
    if resp.code=='200' then 
      puts GREEN+'Welcome, '+username.capitalize+NORMAL
    else
      puts RED+'Access denied'+NORMAL
      abort
    end
    while true
      print "\nSelect command: "+menu+' -> '
      resp=gets().chop!
      case(resp)
        when 'l' then
          reqs = Net::HTTP::Get.new(URI.parse(url))
          reqs.basic_auth username, password
          resp=http.request(reqs)
          print resp.code,'  ',resp.message,"\n"
          if resp.code == '200'then
            obj=JSON.parse(resp.body)
            printf(BLUE_BOLD+"%-30s %-30s\n"+NORMAL,'Name','Birthday')
            obj.each {|n| printf("%-30s %-30s\n",n[0],n[1])}
          end
        when 's' then
          print "Enter name   -> "
          name=gets().chop!
          reqs = Net::HTTP::Get.new(URI.parse(url+'/'+name))
          reqs.basic_auth username, password
          resp=http.request(reqs)
          print resp.code,'  ',resp.message,"\n"
          if resp.code == '200' then
            printf("%s \t\t%s\n",name,resp.body)
          end
        when 'a' then
          print "Enter name -> "
          name=gets().chop!
          print "Enter birth date  -> "
          dob=gets().chop!
          reqs = Net::HTTP::Post.new(URI.parse(url))
          reqs.basic_auth username, password
          reqs.set_form_data('name' => name, 'dob' => dob)
          resp=http.request(reqs)
          print resp.code,'  ',resp.message,"\n"
        when 'd' then
          print "Enter name   -> "
          name=gets().chop!
          reqs=Net::HTTP::Delete.new(URI.parse(url+'/'+name))
          resp=http.request(reqs)
          reqs.basic_auth username, password
          resp=http.request(reqs)
          print resp.code,'  ',resp.message,"\n"
        when 'u' then
          print "Enter name -> "
          name=gets().chop!
          print "Enter birth date  -> "
          dob=gets().chop!
          reqs=Net::HTTP::Put.new(URI.parse(url+'/'+name))
          reqs.set_form_data('dob' => dob)
          reqs.basic_auth username, password
          resp=http.request(reqs)
          print resp.code,'  ',resp.message,"\n"
        when 'q' then
          exit
        else 
	        puts RED+'Invalid command !'+NORMAL
      end #end case
    end #end while
  end #end net::http block
rescue SystemCallError      #Top level catch-all
#rescue Errno::ECONNREFUSED #Connection refused
  print  $!
  abort
end #end begin

