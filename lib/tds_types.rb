module Syspy
  class TdsTypes
    TYPES = [
      [0x2f, "SYBCHAR"         , "char"             , -1, -1,    1, false, false, String          ],
      [0x27, "SYBVARCHAR"      , "varchar"          , -1, -1,    1, false, false, String          ],
      [0x26, "SYBINTN"         , "int"              , -1, 10,   11, true , false, Integer         ],
      [0x30, "SYBINT1"         , "tinyint"          ,  1,  3,    4, false, false, Integer         ],
      [0x34, "SYBINT2"         , "smallint"         ,  2,  5,    6, true , false, Integer         ],
      [0x38, "SYBINT4"         , "int"              ,  4, 10,   11, true , false, Integer         ],
      [0x7f, "SYBINT8"         , "bigint"           ,  8, 19,   20, true , false, Integer         ],
      [0x3e, "SYBFLT8"         , "float"            ,  8, 15,   24, true , false, Float           ],
      [0x3d, "SYBDATETIME"     , "datetime"         ,  8, 23,   23, false, false, Time            ],
      [0x32, "SYBBIT"          , "bit"              ,  1,  1,    1, false, false, Integer         ],
      [0x23, "SYBTEXT"         , "text"             , -4, -1,   -1, false, true , String          ],
      [0x63, "SYBNTEXT"        , "ntext"            , -4, -1,   -1, false, true , String          ],
      [0xae, "SYBUNITEXT"      , "unitext"          , -4, -1,   -1, false, true , String          ],
      [0x22, "SYBIMAGE"        , "image"            , -4, -1,   -1, false, false, String          ],
      [0x7a, "SYBMONEY4"       , "smallmoney"       ,  4, 10,   12, true , false, Integer         ],
      [0x3c, "SYBMONEY"        , "money"            ,  8, 19,   21, true , false, Integer         ],
      [0x31, "SYBDATETIME4"    , "smalldatetime"    ,  4, 16,   19, false, false, Time            ],
      [0x3b, "SYBREAL"         , "real"             ,  4,  7,   14, true , false, Integer         ],
      [0x2d, "SYBBINARY"       , "binary"           , -1, -1,    2, false, false, String          ],
      [0x1f, "SYBVOID"         , "void"             , -1,  1,    1, false, false, nil             ],
      [0x25, "SYBVARBINARY"    , "varbinary"        , -1, -1,   -1, false, false, String          ],
      [0xa7, "SYBNVARCHAR"     , "nvarchar"         , -1, -1,   -1, false, false, String          ],
      [0x68, "SYBBITN"         , "bit"              , -1,  1,    1, false, false, Integer         ],
      [0x6c, "SYBNUMERIC"      , "numeric"          , -1, -1,   -1, true , false, Integer         ],
      [0x61, "SYBDECIMAL"      , "decimal"          , -1, -1,   -1, true , false, Integer         ],
      [0x6d, "SYBFLTN"         , "float"            , -1, 15,   24, true , false, Float           ],
      [0x6e, "SYBMONEYN"       , "money"            , -1, 19,   21, true , false, Integer         ],
      [0x6f, "SYBDATETIMN"     , "datetime"         , -1, 23,   23, false, false, Time            ],
      [0x31, "SYBDATE"         , "date"             ,  4, 10,   10, false, false, Time            ],
      [0x33, "SYBTIME"         , "time"             ,  4,  8,    8, false, false, Time            ],
      [0x7b, "SYBDATEN"        , "date"             , -1, 10,   10, false, false, Time            ],
      [0x93, "SYBTIMEN"        , "time"             , -1,  8,    8, false, false, Time            ],
      [0xaf, "XSYBCHAR"        , "char"             , -2, -1,   -1, false, true , String          ],
      [0xa7, "XSYBVARCHAR"     , "varchar"          , -2, -1,   -1, false, true , String          ],
      [0xe7, "XSYBNVARCHAR"    , "nvarchar"         , -2, -1,   -1, false, true , String          ],
      [0xef, "XSYBNCHAR"       , "nchar"            , -2, -1,   -1, false, true , String          ],
      [0xa5, "XSYBVARBINARY"   , "varbinary"        , -2, -1,   -1, false, false, String          ],
      [0xad, "XSYBBINARY"      , "binary"           , -2, -1,   -1, false, false, String          ],
      [0xe1, "SYBLONGBINARY"   , "varbinary"        , -5, -1,    2, false, false, String          ],
      [0x40, "SYBSINT1"        , "tinyint"          ,  1,  2,    3, false, false, Integer         ],
      [0x41, "SYBUINT2"        , "unsigned smallint",  2,  5,    6, false, false, Integer         ],
      [0x42, "SYBUINT4"        , "unsigned int"     ,  4, 10,   11, false, false, Integer         ],
      [0x43, "SYBUINT8"        , "unsigned bigint"  ,  8, 20,   20, false, false, Integer         ],
      [0x44, "SYBUINTN"        , "unsigned int"     , -1, 10,   11, true , false, Integer         ],
      [0x24, "SYBUNIQUE"       , "uniqueidentifier" , -1, 36,   36, false, false, String          ],
      [0x62, "SYBVARIANT"      , "sql_variant"      , -5,  0, 8000, false, false, String          ],
      [0xbf, "SYBSINT8"        , "bigint"           ,  8, 19,   20, true , false, Integer         ],     
      [0xf1, "XML"             , "xml"              , -4, -1,   -1, false, true , String          ]
    ]

    NAMES = {}
    RUBY_TYPES = {}
    FIXED_LENGTHS = {}
    SIGNED = {}

    TYPES.each(){|type|
      code = type[0]
      name = type[1]
      length = type[3]
      signed = type[6]
      ruby_type = type[8]

      const_set(name,code)
    
      NAMES[code] = name
      FIXED_LENGTHS[code] = length
      SIGNED[code] = signed
      RUBY_TYPES[code] = ruby_type
    }

    def self.name(code)
      NAMES[code]
    end

    def self.numeric?(code)
     code == SYBNUMERIC || code == SYBDECIMAL
    end
    
    def self.fixed_length(code)
      FIXED_LENGTHS[code]
    end

    def self.signed?(code)
      SIGNED[code]
    end

    def self.ruby_type(code)
      RUBY_TYPES[code]
    end
  end
end