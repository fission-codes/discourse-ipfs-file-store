# name: discourse-ipfs-file-store
# about: Upload your files to IPFS
# version: 0.0.1
# authors: The Fission.codes team

require "file_store/base_store"

enabled_site_setting :ipfs_storage_enabled

after_initialize do

  SiteSetting::Upload.class_eval do
    class << self
      alias_method :core_s3_cdn_url, :s3_cdn_url
      alias_method :core_enable_s3_uploads, :enable_s3_uploads
      alias_method :core_absolute_base_url, :absolute_base_url
      alias_method :core_s3_base_url, :s3_base_url
    end

    def self.s3_cdn_url
      if SiteSetting.ipfs_storage_enabled
        "https://#{SiteSetting.ipfs_storage_gateway}/ipfs/"
      else
        core_s3_cdn_url
      end
    end

    def self.enable_s3_uploads
      return true if SiteSetting.ipfs_storage_enabled
      core_enable_s3_uploads
    end

    def self.s3_base_url
      return "//#{SiteSetting.ipfs_storage_gateway}/ipfs/" if SiteSetting.ipfs_storage_enabled
      core_s3_base_url
    end

    def self.absolute_base_url
      return "//#{SiteSetting.ipfs_storage_gateway}/ipfs/" if SiteSetting.ipfs_storage_enabled
      core_absolute_base_url
    end
  end

  Discourse.module_eval do
    class << self
      alias_method :core_store, :store
    end
    def self.store
      if SiteSetting.ipfs_storage_enabled
        @ipfs_store_loaded ||= require './plugins/discourse-ipfs-file-store/lib/ipfs_store'
        FileStore::IpfsStore.new
      else
        core_store
      end
    end
  end
end

load File.expand_path("../lib/validators/ipfs_gateway_validator.rb", __FILE__)
