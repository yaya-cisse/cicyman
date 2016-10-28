require 'singleton'
require 'securerandom'
require 'couchbase'

module Cicyman
  class CouchbaseManager
    include Singleton
    attr_accessor :hostname, :port, :bucket

    def initialize
      @hostname = nil
      @port = nil
      @bucket = nil
    end

    def connection
      @conn ||= Couchbase.connect(:hostname => @hostname, :port => @port, :bucket => @bucket)
    end

    def self.get_file(file_id)
      Cicyman.couchbase.connection.get(file_id)
    end

    def self.set_file(file_id, binary)
      file_id = SecureRandom.uuid
      @file_key = file_id
      Cicyman.couchbase.connection.set(@file_key, binary, :format => :plain)
      file_id
    end

    def self.destroy_file(id)
      if id
        Cicyman.couchbase.connection.delete(id)
      end
    end
  end
end
