require 'active_support'
require 'active_support/core_ext'
require 'after_do'

module Cicyman
  module FileManager
    extend ActiveSupport::Concern
    FileManager.singleton_class.extend AfterDo

    included do
      FileManager.singleton_class.after :set_file do :save_file end
    end

    def self.get_file(file_id)
      self.provider.constantize.get_file(file_id)
    end

    def self.set_file(file_id=nil, binary)
      self.provider.constantize.set_file(file_id, binary)
    end

    def self.destroy_file(file_id)
      self.provider.constantize.destroy_file(file_id)
    end

    private
    def self.save_file
      self.provider.constantize.save_file
    end
  end
end
