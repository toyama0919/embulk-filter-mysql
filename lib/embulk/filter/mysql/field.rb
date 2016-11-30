module Embulk
  module Filter
    class Mysql < FilterPlugin
      class Field
        TYPE_DECIMAL     = 0
        TYPE_TINY        = 1
        TYPE_SHORT       = 2
        TYPE_LONG        = 3
        TYPE_FLOAT       = 4
        TYPE_DOUBLE      = 5
        TYPE_NULL        = 6
        TYPE_TIMESTAMP   = 7
        TYPE_LONGLONG    = 8
        TYPE_INT24       = 9
        TYPE_DATE        = 10
        TYPE_TIME        = 11
        TYPE_DATETIME    = 12
        TYPE_YEAR        = 13
        TYPE_NEWDATE     = 14
        TYPE_VARCHAR     = 15
        TYPE_BIT         = 16
        TYPE_TIMESTAMP2  = 17
        TYPE_DATETIME2   = 18
        TYPE_TIME2       = 19
        TYPE_JSON        = 245
        TYPE_NEWDECIMAL  = 246
        TYPE_ENUM        = 247
        TYPE_SET         = 248
        TYPE_TINY_BLOB   = 249
        TYPE_MEDIUM_BLOB = 250
        TYPE_LONG_BLOB   = 251
        TYPE_BLOB        = 252
        TYPE_VAR_STRING  = 253
        TYPE_STRING      = 254
        TYPE_GEOMETRY    = 255
        TYPE_CHAR        = TYPE_TINY
        TYPE_INTERVAL    = TYPE_ENUM

        # Flag
        NOT_NULL_FLAG         = 1
        PRI_KEY_FLAG          = 2
        UNIQUE_KEY_FLAG       = 4
        MULTIPLE_KEY_FLAG     = 8
        BLOB_FLAG             = 16
        UNSIGNED_FLAG         = 32
        ZEROFILL_FLAG         = 64
        BINARY_FLAG           = 128
        ENUM_FLAG             = 256
        AUTO_INCREMENT_FLAG   = 512
        TIMESTAMP_FLAG        = 1024
        SET_FLAG              = 2048
        NO_DEFAULT_VALUE_FLAG = 4096
        ON_UPDATE_NOW_FLAG    = 8192
        NUM_FLAG              = 32768
        PART_KEY_FLAG         = 16384
        GROUP_FLAG            = 32768
        UNIQUE_FLAG           = 65536
        BINCMP_FLAG           = 131072
      end
    end
  end
end
