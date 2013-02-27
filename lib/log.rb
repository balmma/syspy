require "logger"

module Syspy
  class Log

    LOG_FILE = "syspy.log"
    LOGGERS = []
    
    STDOUT_LOG = Logger.new(STDOUT)
    STDOUT_LOG.level = Logger::INFO

    #FILE_LOG = Logger.new(LOG_FILE)
    #FILE_LOG.level = Logger::INFO

    LOGGERS << STDOUT_LOG
    #LOGGERS << FILE_LOG
    
    def self.fatal(message)
      self.log(Logger::FATAL,message)
    end

    def self.error(message)
      self.log(Logger::ERROR,message)
    end

    def self.warn(message)
      self.log(Logger::WARN,message)
    end

    def self.info(message)
      self.log(Logger::INFO,message)
    end

    def self.debug(message)
      self.log(Logger::DEBUG,message)
    end

    def self.log(severity,message) 
      LOGGERS.each(){|logger|
        logger.log(severity,message)
      } 
    end
    
  end
end