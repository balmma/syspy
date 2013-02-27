module Syspy
  class TdsTokens
    TOKENS = [   
      ["TDS_ALTFMT", 0xA8, 2],
      ["TDS_ALTNAME", 0xA7, 2],
      ["TDS_ALTROW", 0xD3, nil],
      ["TDS_CAPABILITY", 0xE2, 2], 
      ["TDS_COLINFO", 0xA5, 2],
      ["TDS_COLINFO2", 0x20, 4],
      ["TDS_CONTROL", 0xAE, 2],
      ["TDS_CURCLOSE", 0x80, 2],
      ["TDS_CURDECLARE", 0x86, 2],
      ["TDS_CURDECLARE2", 0x23, 4],
      ["TDS_CURDECLARE3", 0x10, 4],
      ["TDS_CURDELETE", 0x81, 2],
      ["TDS_CURFETCH", 0x82, 2],
      ["TDS_CURINFO", 0x83, 2],
      ["TDS_CURINFO2", 0x87, 2],
      ["TDS_CURINFO3", 0x88, 2],
      ["TDS_CUROPEN", 0x84, 2],
      ["TDS_CURUPDATE", 0x85, 2],
      ["TDS_DBRPC", 0xE6, 2],
      ["TDS_DBRPC2", 0xE8, 2],
      ["TDS_DONE", 0xFD, [8]],
      ["TDS_DONEINPROC", 0xFF, [8]],
      ["TDS_DONEPROC", 0xFE, [8]],
      ["TDS_DYNAMIC", 0xE7, 2],
      ["TDS_DYNAMIC2", 0x62, 4],
      ["TDS_EED", 0xE5, 2],
      ["TDS_ENVCHANGE", 0xE3, 2],
      ["TDS_ERROR", 0xAA, 2],
      ["TDS_EVENTNOTICE", 0xA2, 2],
      ["TDS_INFO", 0xAB, 2],
      ["TDS_KEY", 0xCA, nil],
      ["TDS_LANGUAGE", 0x21, 4],
      ["TDS_LOGINACK", 0xAD, 2],
      ["TDS_LOGOUT", 0x71, [1]],
      ["TDS_MSG", 0x65, 1, 1],
      ["TDS_OFFSET", 0x78, [4]],
      ["TDS_OPTIONCMD", 0xA6, 2],
      ["TDS_ORDERBY", 0xA9, 2],
      ["TDS_ORDERBY2", 0x22, 4],
      ["TDS_PARAMFMT", 0xEC, 2],
      ["TDS_PARAMFMT2", 0x20, 4],
      ["TDS_PARAMS", 0xD7, nil],
      ["TDS_RETURNSTATUS", 0x79, [4]],
      ["TDS_RETURNVALUE", 0xAC, 2],
      ["TDS_ROW", 0xD1, nil],
      ["TDS_ROWFMT", 0xEE, 2],
      ["TDS_ROWFMT2", 0x61, 4],
      ["TDS_TABNAME", 0xA4, 2]
    ]

    NAMES = {}
    FIXED_LENGTHS = {}
    LENGTH_FIELD_SIZES = {}
    STREAM_CLASSES = {}

    TOKENS.each(){|values|
      name = values[0]
      token = values[1]
      length = values[2]

      self.const_set(name,token)

      NAMES[token] = name
      if(length)
        if(length.instance_of?(Array))
          FIXED_LENGTHS[token] = length.first
        else
          LENGTH_FIELD_SIZES[token] = length
        end
      end  
        
      class_file_name = name.downcase       
      if(File.exist?(File.join(File.dirname(__FILE__),"tds_packages/#{class_file_name}.rb")))
        require File.join(File.dirname(__FILE__),"tds_packages/#{class_file_name}")
        class_name =  class_file_name.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
        cl = eval(class_name)
        STREAM_CLASSES[token] = cl
      end
    }

    def self.token?(token)
      NAMES.include?(token)
    end

    def self.token_name(token)
      NAMES[token]
    end

    def self.token_class(token)
      STREAM_CLASSES[token]
    end

    def self.fixed_length(token)
      FIXED_LENGTHS[token]
    end

    def self.length_field_size(token)
      LENGTH_FIELD_SIZES[token]
    end    
  end
end