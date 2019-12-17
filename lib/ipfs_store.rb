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
      # path = get_path_for_optimized_image(optimized_image)
      # url, optimized_image.etag = store_file(file, path, content_type: content_type, private_acl: secure)
      # url
    end

    # options
    #   - filename
    #   - content_type
    #   - cache_locally
    def store_file(file, path, opts = {})
      # raise "not implemented in IPFS Store - store file"
      filename = opts[:filename].presence || File.basename(path)
      cache_file(file, File.basename(path)) if opts[:cache_locally]
      content_type = opts[:content_type].presence || MiniMime.lookup_by_filename(filename)&.content_type
      # add a "content disposition" header for "attachments"
      options[:content_disposition] = "attachment; filename*=UTF-8''#{URI.encode(filename)}" unless FileHelper.is_supported_media?(filename)
      path.prepend(File.join(upload_path, "/")) if Rails.configuration.multisite

      uri = URI.parse("https://runfission.com/ipfs")
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(SiteSetting.fission_ipfs_storage_username, SiteSetting.fission_ipfs_storage_password)
      request.content_type = content_type
      request.body = ""

      byebug


      request.body << File.read(file).delete("\r\n")

      byebug


      # # req_options = {
      # #   use_ssl: uri.scheme == "https",
      # # }

      # # response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      # #   http.request(request)
      # # end

      # "#{absolute_base_url}/#{response.body}"
    end

    def cdn_url(url)
#      raise "not implemented in IPFS Store - cdn_url"
      return url if SiteSetting.Upload.s3_cdn_url.blank?
      schema = url[/^(https?:)?\/\//, 1]
      url.sub(File.join("#{schema}#{absolute_base_url}"), File.join(SiteSetting.Upload.s3_cdn_url, "/"))
    end

    def absolute_base_url
      @absolute_base_url ||= SiteSetting.Upload.absolute_base_url
    end
  end
end
