# frozen_string_literal: true

require 'rails_helper'
require 'discourse'
require 'byebug'

describe Discourse do
  context "#store" do
    it "returns IpfsStore when IPFS is enabled" do
      SiteSetting.ipfs_storage_enabled = true
      SiteSetting.ipfs_storage_gateway = "runfission.com"
      SiteSetting.ipfs_storage_username = "test_username"
      SiteSetting.ipfs_storage_password = "test_password"

      byebug

      expect(Discourse.store).to be_a(FileStore::IpfsStore)
    end
  end
end
