require "tds_package" 

module Syspy
  class TdsParamfmt2 < TdsPackage
    
    attr_reader :params_count, :parameters

    def initialize(io,length)
      @params_count = read_uint16(io)     
      @parameters = []
     
      1.upto(@params_count){
        parameter = {}
        name_length = read_uint(io)
        parameter[:name_length] = name_length
        if(name_length > 0)
          parameter[:param_name] = read_text(io,name_length)
        end
        parameter[:status] = read_uint32(io)
        parameter[:user_type] = read_int32(io)
        data_type = read_uint(io)
        parameter[:data_type] = data_type        

        data_length = TdsTypes.fixed_length(data_type)         

        case data_length
          when -5
            data_length = Bytes.int32le(io)
          when -4
            data_length = Bytes.int32le(io)
          when -2
            data_length = Bytes.int32le(io)
          when -1
            data_length = Bytes.uint(io) 
        end       
        
        parameter[:length] = data_length

        if(TdsTypes.numeric?(data_type))
          parameter[:precision] = read_uint(io)
          parameter[:scale] = read_uint(io)
        end

        locale_length = read_uint(io)
        parameter[:locale_length] = locale_length
        if(locale_length > 0)
          parameter[:locale_info] = read_text(io,locale_length)
        end       
        @parameters << parameter
      }     
    end
  end
end