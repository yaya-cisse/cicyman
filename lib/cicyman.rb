require "cicyman/version"
require "cicyman/glusterfs"
require "cicyman/couchbase"
require "cicyman/mongo"
require "cicyman/mysql"
require 'rubygems'
require 'bundler'
require 'active_support'
require 'active_support/core_ext'
require 'active_model'
require 'moped'
require 'tzinfo'
require 'origin'
require 'mysql2'
require 'activerecord-mysql2-adapter'
# require 'after_do'

module Cicyman

  # extend ActiveSupport::Concern
  # Cicyman.singleton_class.extend AfterDo

  # included do
  # Cicyman.singleton_class.after :set_file do :save_file end
  # end

  class << self
    attr_accessor :provider, :glusterfs, :couchbase, :mongo, :mysql
  end

  def self.glusterfs
    @glusterfs ||= GlusterfsManager.instance
  end

  def self.couchbase
    @couchbase ||= CouchbaseManager.instance
  end

  def self.mongo
    @mongo ||= MongoManager.new
  end

  def self.mysql
    @mysql ||= MysqlManager.new
  end

  def self.configure
    yield self
  end

  def self.configure_glusterfs
    yield(glusterfs)
  end

  def self.configure_couchbase
    yield(couchbase)
  end

  def self.configure_mongo
    yield(mongo)
  end

  def self.configure_mysql
    yield(mysql)
  end

  def self.get_file(file_id)
    ("Cicyman::"+self.provider).constantize.get_file(file_id)
  end

  def self.set_file(file_id=nil, binary)
    ("Cicyman::"+self.provider).constantize.set_file(file_id, binary)
  end

  def self.destroy_file(file_id)
    ("Cicyman::"+self.provider).constantize.destroy_file(file_id)
  end

  # private
  # def self.save_file
  #   self.provider.constantize.save_file
  # end
end


# Cicyman.configure do |config|
#   config.provider = "GlusterfsManager"
# end

# Cicyman.configure_glusterfs do |config|
#   config.volume = 'gfsvol'
#   config.hostname = 'abdelhafiz-Ubnt'
#   config.directory = '/some_dir1'
#   config.volume_mount
# end



# Cicyman.configure do |config|
#   config.provider = "CouchbaseManager"
# end

# Cicyman.configure_couchbase do |config|
#   config.hostname = "172.17.0.2"
#   config.port = 8091
#   config.bucket = "proto_database"
# end



# Cicyman.configure do |config|
#   config.provider = "MongoManager"
# end

# Cicyman.configure_mongo do |config|
#   config.loadpath = Dir.pwd+"/mongoid.yml"
#   config.load_yaml
# end



# Cicyman.configure do |config|
#   config.provider = "MysqlManager"
# end

# Cicyman.configure_mysql do |config|
#   config.loadpath = Dir.pwd+"/database.yml"
#   config.load_yaml
# end
