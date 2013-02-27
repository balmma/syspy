require "tds_package" 

module Syspy
  class TdsParams < TdsPackage
    
    attr_reader :params_count, :parameters

    def initialize(io,paramfmt)
      @parameters = []
      paramfmt.parameters.each(){|format|
        @parameters << read_data(io,format)
      }          
    end

    def read_data(io,format)
      data_type = format[:data_type]
      case data_type
        when TdsTypes::SYBINTN
          len = read_int(io)                          
          return Bytes.intle(io,len)
        when TdsTypes::SYBINT1
          return Bytes.int(io)
        when TdsTypes::SYBINT2
          return Bytes::int16le(io)
        when TdsTypes::SYBINT4
          return Bytes::int32le(io)
        when TdsTypes::SYBCHAR, TdsTypes::SYBVARCHAR, TdsTypes::XSYBCHAR
          len = read_uint(io)         
          if (len > 0)
             val = read_text(io,len)
            # In TDS 4/5 zero length varchars are stored as a
            # single space to distinguish them from nulls.
            if(len == 1 && data_type == TdsTypes::SYBVARCHAR)
              return " " == val ? "" : val     
            end              
            return val
          end
        when TdsTypes::SYBDATETIME4, TdsTypes::SYBDATETIMN, TdsTypes::SYBDATETIME
          read_datetime(io,data_type)
        else
          raise "Unhandled data type: #{TdsTypes.name(data_type)} (0x#{data_type.to_s(16)})"
      end
    end
   
    TIME_DIFF = Time.at(0).utc - Time.utc(1900,1,1)

    def read_datetime(io,data_type)     
      case data_type
        when TdsTypes::SYBDATETIMN
          len = read_uint(io)
        when TdsTypes::SYBDATETIME4
          len = 4;
        else 
          len = 8;
      end
             
      case len
        when 0
          return nil
        when 8
          days = read_int32(io)
          time = read_int32(io)
          return Time.at(days  * 24 * 3600 - TIME_DIFF + time / 300).utc
        when 4
          days = read_int16le(io)
          time = read_int16le(io)
          return Time.at(days * 24 * 3600 + time * 60).utc
      end
    end
  end
end