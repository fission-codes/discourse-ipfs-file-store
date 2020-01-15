require 'net/http'
require 'uri'
require "mini_mime"
require 'byebug'
require_dependency "file_store/base_store"

module FileStore
  class IpfsStore < ::FileStore::BaseStore

    def store_upload(file, upload, content_type = nil)
      path = get_path_for_upload(upload)
      store_file(file, path, content_type: content_type, filename: upload.original_filename)#, cache_locally: true)
    end

    # options
    #   - cache_locally
    def store_file(file, path, opts = {})
      Rails.logger.info("---------------- Store File")
      cache_file(file, File.basename(path)) if opts[:cache_locally]

      path.prepend(File.join(upload_path, "/")) if Rails.configuration.multisite

      # Can only upload files through Fission right now.
      uri = URI.parse("https://runfission.com/ipfs")
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(SiteSetting.ipfs_storage_username, SiteSetting.ipfs_storage_password)
      request.content_type = "application/octet-stream"
      request.body = ""

      request.body << File.read(file)

      req_options = {
        use_ssl: uri.scheme == "https"
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      "#{absolute_base_url}#{response.body}"
    end

    def remove_file(url, path)
      # We don't delete files from IPFS so this method is a no-op
    end

    def purge_tombstone(grace_period)
      # We don't delete files from IPFS so this method is a no-op
    end

    def cdn_url(url)
      return url if SiteSetting.Upload.s3_cdn_url.blank?
      schema = url[/^(https?:)?\/\//, 1]
      url.sub(File.join("#{schema}#{absolute_base_url}"), File.join(SiteSetting.Upload.s3_cdn_url, "/"))
    end

    def absolute_base_url
      @absolute_base_url ||= SiteSetting.Upload.absolute_base_url
    end

    def external?
      true
    end

    ### Implement below this line.

    def has_been_uploaded(url)
      Rails.logger.info("---------------- Has been uploaded")
      return false if url.blank?

      base_hostname = URI.parse(absolute_base_url).hostname
      return true if url[base_hostname]

      return false if SiteSetting.Upload.cdn_url.blank?
      cdn_hostname = URI.parse(SiteSetting.Upload.cdn_url || "").hostname
      cdn_hostname.presence && url[cdn_hostname]
    end

    def store_optimized_image(file, optimized_image, content_type = nil, secure: false)
      Rails.logger.info("---------------- Store Optimized Image")
      # raise "not implemented in IPFS Store - store optimized image"
      # need to implement
      path = get_path_for_optimized_image(optimized_image)
      url = store_file(file, path)

      # byebug
      url
    end

    def path_for(upload)
      Rails.logger.info("---------------- Path For")
      # raise "not implemented in IPFS Store - path_for"
      # need to implement
      url = upload.try(:url)
      FileStore::LocalStore.new.path_for(upload) if url && url[/^\/[^\/]/]
      # url if url.present?
      # Below from S3 Store. Not sure why it's returing a localstore object.
    end
  end
end
