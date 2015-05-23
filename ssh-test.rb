$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
require 'net/ssh' 
Net::SSH.start( 'roberto-inspiron-6000', 
:password=>'texas',
:username=>'roberto',) do |session|
  session.process.open("ls") do |ls|
    
    ls.on_stdout do |data|
    puts "--> #{data}"
    end

  end
  
end
