require 'rubygems'
require 'spec'

require "#{ File.dirname __FILE__ }/../lib/sequel_notnaughty.rb"

def subject() ::NotNaughty end
def h(something)
  puts '<pre>%s</pre>' %
  something.inspect.gsub(/[<>]/) {|m| (m == '<')? '&lt;': '&gt;'}
end
