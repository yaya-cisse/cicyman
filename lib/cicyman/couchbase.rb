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
      # @my_file ||= (
      #     CouchbaseManager.instance.connection.get(file_id)
      # )
    end

    def self.set_file(file_id, binary)
      @my_file = binary
      file_id = SecureRandom.uuid
      @file_key = file_id
      Cicyman.couchbase.connection.set(@file_key, @my_file, :format => :plain)
      file_id
    end

    def self.save_file
      Cicyman.couchbase.connection.set(@file_key, @my_file, :format => :plain)
    end

    def self.destroy_file(id)
      if id
        Cicyman.couchbase.connection.delete(id)
      end
    end
  end
end
