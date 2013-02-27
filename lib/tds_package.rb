require "bytes"

module Syspy
  
  class ParseError < Exception
  end

  class TdsPackage
    
    def read_uint(io)
      Bytes.uint(io)
    end

    def read_uint32(io)
      Bytes.uint32le(io)
    end

    def read_uint16(io)
      Bytes.uint16le(io)
    end

    def read_int(io)
      Bytes.int(io)
    end

    def read_int32(io)
       Bytes.int32le(io)
    end

    def read_int16(io)
      Bytes.int16le(io)
    end

    def read_text(io,length)
      io.read(length)
    end

  end
end
