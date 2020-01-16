# frozen_string_literal: true

require 'rails_helper'
require 'byebug'
require './plugins/discourse-ipfs-file-store/lib/ipfs_store'

describe FileStore::IpfsStore do

  let(:store) { FileStore::IpfsStore.new }
  let(:upload) { Fabricate(:upload) }
  let(:uploaded_file) { file_from_fixtures("logo.png") }
  let(:optimized_image) { Fabricate(:optimized_image) }
  let(:optimized_image_file) { file_from_fixtures("logo.png") }

  before(:each) do
    SiteSetting.ipfs_storage_enabled = true
    SiteSetting.ipfs_storage_gateway = "runfission.com"
    SiteSetting.ipfs_storage_username = "test_username"
    SiteSetting.ipfs_storage_password = "test_password"
  end

  describe ".discourse store" do
    it "is an IpfsStore" do
      expect(Discourse.store).to be_a(FileStore::IpfsStore)
    end
  end

  describe ".has_been_uploaded?" do

    it "identifies IPFS uploads" do
      expect(store.has_been_uploaded("//#{SiteSetting.ipfs_storage_gateway}/ipfs/QmaGoJnvNWyTWbHB99PgUq9KAGhcsVxXM741TPaQg9aMbB")).to eq(true)
    end

    it "does not match other urls" do
      expect(store.has_been_uploaded("//foobar.com/ipfs/12345")).to eq(false)
    end
  end

  describe ".absolute_base_url" do
    it "returns a lowercase schemaless absolute url" do
      expect(store.absolute_base_url).to eq("#{SiteSetting.Upload.absolute_base_url}")
    end
  end

  it "is external" do
    expect(store.external?).to eq(true)
    expect(store.internal?).to eq(false)
  end

  describe ".path_for" do
    def assert_path(path, expected)
      upload = Upload.new(url: path)

      path = store.path_for(upload)
      expected = FileStore::LocalStore.new.path_for(upload) if expected

      expect(path).to eq(expected)
    end

    it "correctly falls back to local" do
      assert_path("/hello", "/hello")
      assert_path("//hello", nil)
      assert_path("http://hello", nil)
      assert_path("https://hello", nil)
    end
  end
end
