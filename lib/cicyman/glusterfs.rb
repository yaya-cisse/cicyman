require "cicyman/base_provider"
require 'glusterfs'
require 'singleton'

module Cicyman
  class GlusterfsManager < BaseProvider
    include Singleton
    attr_accessor :volume, :hostname, :directory

    def volume_mount
      if !@@volume_mount || @@volume_mount != GlusterFS::Volume.new(@volume)
        @@volume_mount = GlusterFS::Volume.new(@volume)
      end
      @@volume_mount.mount(@hostname)
      @@dir ||= GlusterFS::Directory.new(@@volume_mount, @directory)
      @@dir.create
    end

    def initialize
      @volume = nil
      @hostname = nil
      @directory = nil
    end

    def self.get_file(file_id)
      file = GlusterFS::File.new(@@volume_mount, file_id)
      file.read
    end

    def self.set_file(file_id, binary)
      file_id = @@dir.path+'/'+file_id
      @file = GlusterFS::File.new(@@volume_mount, file_id)
      @file.write(binary)
      file_id
    end

    def self.destroy_file(file_id)
      if file_id
        @@volume_mount.delete_file(file_id)
      end
    end
  end
end
