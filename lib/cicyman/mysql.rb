require 'active_record'
require 'mysql2'
# require 'activerecord-mysql2-adapter'

module Cicyman
  class MysqlManager
    attr_accessor :loadpath

    def initialize
      @loadpath = nil
    end

    def load_yaml
      @dbconfig = YAML.load(File.read(@loadpath))
      # ActiveRecord::Base.establish_connection("mysql2://root:mditest@172.17.0.4/prototypes_db")
    end

    def self.get_file(file_id)
      @my_file ||= MysqlManager::Fichier.find(file_id).content if file_id
    end

    def self.set_file(file_id, binary)
      unless file_id
        @file = MysqlManager::Fichier.create()
        file_id = @file.id
      else
        @file = MysqlManager::Fichier.find(file_id)
      end
      @file.content = binary
      @file.save
      file_id
    end

    def self.destroy_file(id)
      if id
        file = MysqlManager::Fichier.find(id)
        file.destroy
      end
    end

    class Fichier < ActiveRecord::Base
      attr_accessible :content
    end
  end
end
