require 'mongo'
require 'mongoid'
require 'moped'

module Cicyman
  class MongoManager
    attr_accessor :loadpath

    def initialize
      @loadpath = nil
    end

    def load_yaml
      Mongoid::Config.load!(@loadpath, :development)
    end

    def self.get_file(file_id)
      @my_file ||= MongoManager::Fichier.find(file_id).content if file_id
    end

    def self.set_file(file_id, binary)
      unless file_id
        @file = MongoManager::Fichier.create()
        file_id = @file.id.to_s
      else
        @file = MongoManager::Fichier.find(file_id)
      end
      @file.content = Moped::BSON::Binary.new(:generic,binary)
      @file.save
      file_id
    end

    def self.save_file
      @file.save
    end

    def self.destroy_file(id)
      if id
        file = MongoManager::Fichier.find(id)
        file.destroy
      end
    end

    class Fichier
      include Mongoid::Document
      field :content, type: Moped::BSON::Binary
    end
  end
end
