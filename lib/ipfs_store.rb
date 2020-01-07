require 'net/http'
require 'uri'
require "mini_mime"
require 'byebug'
require_dependency "file_store/base_store"

module FileStore
  class IpfsStore < ::FileStore::BaseStore

    def store_upload(file, upload, content_type = nil)
      #raise "not implemented in IPFS Store - store upload"
      # Rails.logger.info("==================")
      # Rails.logger.info("store upload")
      # Rails.logger.info(file)
      # Rails.logger.info(upload)
      path = get_path_for_upload(upload)
      store_file(file, path, content_type: content_type, filename: upload.original_filename)#, cache_locally: true)
    end

    def store_optimized_image(file, optimized_image, content_type = nil, secure: false)
      raise "not implemented in IPFS Store - store optimized image"
      # need to implement
      # path = get_path_for_optimized_image(optimized_image)
      # url, optimized_image.etag = store_file(file, path, content_type: content_type, private_acl: secure)
      # url
    end

    # options
    #   - cache_locally
    def store_file(file, path, opts = {})
      # raise "not implemented in IPFS Store - store file"
      cache_file(file, File.basename(path)) if opts[:cache_locally]

      path.prepend(File.join(upload_path, "/")) if Rails.configuration.multisite

      uri = URI.parse("https://runfission.com/ipfs")
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(SiteSetting.fission_ipfs_storage_username, SiteSetting.fission_ipfs_storage_password)
      request.content_type = "application/octet-stream"
      request.body = ""

      request.body << File.read(file)

      req_options = {
        use_ssl: uri.scheme == "https"
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      "https:#{absolute_base_url}#{response.body}"
    end

    def remove_file(url, path)
      raise "not implemented in IPFS Store - remove_file"
      # need to implement
    end

    def has_been_uploaded(url)
      raise "not implemented in IPFS Store - has_been_uploaded"
      # need to implement
    end

    def purge_tombstone(grace_period)
      raise "not implemented in IPFS Store - purge_tombstone"
      # need to implement
      blob_list = blob_service.list_blobs(azure_blob_container, {prefix: "tombstone"})
      blob_list.each do |blob|
        last_modified_diff = ((Time.now.utc - Time.parse(blob.properties[:last_modified])) / 1.day).round
        blob_service.delete_blob(azure_blob_container, blob.name) if last_modified_diff > grace_period
      end
    end

    def path_for(upload)
      raise "not implemented in IPFS Store - path_for"
      # need to implement
      url = upload.try(:url)
      FileStore::LocalStore.new.path_for(upload) if url && url[/^\/[^\/]/]
    end

    def cdn_url(url)
      #raise "not implemented in IPFS Store - cdn_url"
      # need to implement
      return url if SiteSetting.Upload.s3_cdn_url.blank?
      schema = url[/^(https?:)?\/\//, 1]
      url.sub(File.join("#{schema}#{absolute_base_url}"), File.join(SiteSetting.Upload.s3_cdn_url, "/"))
    end

    def absolute_base_url
      # raise "not implemented in IPFS Store - absolute_base_url"
      # need to implement
      @absolute_base_url ||= SiteSetting.Upload.absolute_base_url
    end


    def external?
      raise "not implemented in IPFS Store - external?"
      # need to implement
      true
    end
  end
end
