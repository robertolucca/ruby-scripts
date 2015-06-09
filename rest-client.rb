require 'net/http'  #standard ruby library
require 'json'      #gem install json

#ansi escape sequences
#from http://bluesock.org/~willkg/dev/ansi.html#sequences
BLUE_BOLD = "\e[34;1m"
NORMAL = "\e[0m"
RED = "\e[31m"
CLEAR_SCREEN = "\e[2J"

url='http://localhost:4567/FamilyMembers'
#fancy colorized commands menu
cmds='search list add update delete quit'.split(' ')
cmds.each {|w| w.sub!(/([a-z])/,BLUE_BOLD+'\1'+NORMAL)}
menu=cmds.join(' ')
#enclose in begin/end to trap exceptions
begin
  print CLEAR_SCREEN
  while true
  print "\nSelect command: "+menu+' -> '
  resp=gets().chop!
  case(resp)
    when 'l' then
      resp = Net::HTTP.get_response(URI.parse(url))
      print resp.code,'  ',resp.message,"\n"
      if resp.code == '200'then
        obj=JSON.parse(resp.body)
        printf(BLUE_BOLD+"%-30s %-30s\n"+NORMAL,'Name','Birthday')
        obj.each {|n| printf("%-30s %-30s\n",n[0],n[1])}
      end
    when 's' then
      print "Enter name   -> "
      name=gets().chop!
      resp = Net::HTTP.get_response(URI.parse(url+'/'+name))
      print resp.code,'  ',resp.message,"\n"
      if resp.code == '200' then
        printf("%s \t\t%s\n",name,resp.body)
      end
    when 'a' then
      print "Enter name -> "
      name=gets().chop!
      print "Enter birth date  -> "
      dob=gets().chop!
      resp = Net::HTTP.post_form(URI.parse(url),'name' => name, 'dob' => dob)
      print resp.code,'  ',resp.message,"\n"
    when 'd' then
      print "Enter name   -> "
      name=gets().chop!
      uri=URI(url+'/'+name)
      http=Net::HTTP.new(uri.host, uri.port)
      req=Net::HTTP::Delete.new(uri.path)
      resp=http.request(req)
      print resp.code,'  ',resp.message,"\n"
    when 'u' then
      print "Enter name -> "
      name=gets().chop!
      print "Enter birth date  -> "
      dob=gets().chop!
      uri=URI(url+'/'+name)
      http=Net::HTTP.new(uri.host, uri.port)
      req=Net::HTTP::Put.new(uri.path)
      req.set_form_data('dob' => dob)
      resp=http.request(req)
      print resp.code,'  ',resp.message,"\n"
    when 'q' then
      exit
    else 
	    puts RED+'Invalid command !'+NORMAL
    end
end

rescue SystemCallError      #Top level catch-all
#rescue Errno::ECONNREFUSED #Connection refused
  print  $!
  abort
end

