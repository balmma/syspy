require "tds_package" 

module Syspy
  class TdsParamfmt < TdsPackage
    
    attr_reader :params_count, :parameters

    def initialize(io,length)
      @params_count = read_uint16(io)
      puts "TdsParamfmt2: #{@params_count}"
      @parameters = []
      1.upto(@params_count){
        
      }
    end
  end
end