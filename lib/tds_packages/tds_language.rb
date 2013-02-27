require "tds_package" 

module Syspy
  class TdsLanguage < TdsPackage
    
    attr_reader :status, :language_text, :tds_paramfmt, :tds_params
    
    STATUS_PARAMETERIZED = 0x01

    def initialize(io,length)
      @status = read_uint(io)        
      @language_text = read_text(io,length - 1)     
      if(@status == 1 && !io.eof?)
        token = read_uint(io)
        if(token == TdsTokens::TDS_PARAMFMT || token == TdsTokens::TDS_PARAMFMT2)
          paramfmt_length = Bytes.uintle(io,TdsTokens.length_field_size(token))
          if(paramfmt_length < 1000000)          
            @tds_paramfmt = TdsTokens.token_class(token).new(io,paramfmt_length)
            if(@tds_paramfmt.params_count > 0)
              token = read_uint(io)
              if(token == TdsTokens::TDS_PARAMS)
                @tds_params = TdsParams.new(io,@tds_paramfmt)
              end
            end
          else
            Log.warn("Illegal paramfmt length: #{paramfmt_length}")
          end          
        end
      end      
    end
  end
end
