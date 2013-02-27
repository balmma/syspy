require "bindata"

module Syspy
  class Bytes
    def self.uint(io)       
      BinData::Uint8.read(io).to_i        
    end

    def self.uintle(io,length)
      case length
        when 1
          BinData::Uint8.read(io).to_i
        when 2
          BinData::Uint16le.read(io).to_i
        when 4
          BinData::Uint32le.read(io).to_i
        else
          raise ArgumentError.new("Invalid length")
      end
    end

    def self.uint16le(io)    
      BinData::Uint16le.read(io).to_i
    end
    
    def self.uint32le(io)
      BinData::Uint32le.read(io) .to_i      
    end

    def self.uintbe(io,length)
      case length
        when 1
          BinData::Uint8.read(io).to_i
        when 2
          BinData::Uint16be.read(io).to_i
        when 4
          BinData::Uint32be.read(io).to_i
        else
          raise ArgumentError.new("Invalid length")
      end
    end
   
    def self.uint16be(io)    
      BinData::Uint16be.read(io).to_i
    end
    
    def self.uint32be(io)
      BinData::Uint32be.read(io).to_i      
    end

    def self.int(io)
      BinData::Int8.read(io).to_i
    end

    def self.intle(io,length)
      case length
        when 1
          BinData::Int8.read(io).to_i
        when 2
          BinData::Int16le.read(io).to_i
        when 4
          BinData::Int32le.read(io).to_i
        else
          raise ArgumentError.new("Invalid length")
      end
    end

    def self.int16le(io)    
      BinData::Int16le.read(io).to_i
    end
    
    def self.int32le(io)
      BinData::Int32le.read(io).to_i      
    end
    
    def self.intbe(io,length)
      case length
        when 1
          BinData::Int8.read(io).to_i
        when 2
          BinData::Int16be.read(io).to_i
        when 4
          BinData::Int32be.read(io).to_i
        else
          raise ArgumentError.new("Invalid length")
      end
    end

    def self.int16be(io)    
      BinData::Int16be.read(io).to_i
    end
    
    def self.int32be(io)
      BinData::Int32be.read(io).to_i       
    end 

  end
end
