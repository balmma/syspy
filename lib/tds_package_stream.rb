require "stringio"
require "thread"

require "bytes"
require "tds_types"
require "tds_tokens"

module Syspy
  class TdsPackageStream
    
    HEADER_LENGTH = 45
    HEADER_REGEXP = /\d{3}\.\d{3}\.\d{3}\.\d{3}\.\d{5}-\d{3}\.\d{3}\.\d{3}\.\d{3}\.\d{5}: /

    def initialize(interface,dst,dst_port)
      @interface = interface
      @dst = dst
      @dst_port = dst_port
      @in,@out = IO.pipe()
    end

    def each_package()
      Thread.abort_on_exception = true       
      @tcpdump_thread = Thread.new(){             
        IO.popen("#{File.dirname(__FILE__)}/tcpflow -c -B -i #{@interface} tcp and dst #{@dst} and dst port #{@dst_port} 2>/dev/null"){|io|         
          content = ""
          loop(){           
            content << io.read(1)
            
            if(content.match(HEADER_REGEXP))                           
              payload = content[0..(-2 - HEADER_LENGTH)]
              @out.write(payload)
              @out.flush
              content = ""
            end
           
            Log.debug "Network package done"      
          }
        } 
      }  

      content = ""
      @in.each_byte(){|byte|
        if(byte == 0x0F)                 
          last_packet_indicator = Bytes.uint(@in)          
          length = Bytes.uint16be(@in)
           
          # skip next 4 bytes of the header
          if(Bytes.uint32be(@in) == 0x00)
            content << @in.read(length - 8)
            
            if(last_packet_indicator == 0x1)              
              begin
                io = StringIO.new(content)
                package = handle_package(io)
                yield package if package               
              ensure
                content = ""
              end             
            end
          end
        end           
      }     
    end

    def handle_package(io)    
      token = Bytes.uint(io)
      token_class = TdsTokens.token_class(token)
      if(token_class)
        length = TdsTokens.fixed_length(token)
        unless(length)
          length_field_size = TdsTokens.length_field_size(token)
          if(length_field_size)
            length = Bytes.uintle(io,length_field_size)
          end       
        end
        Log.debug("Got #{TdsTokens.token_name(token)} of #{length} bytes")
        package = token_class.new(io,length)
        return package        
      end
      nil   
    end     
  end
end