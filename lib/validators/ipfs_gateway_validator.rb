require 'uri'
class IpfsGatewayValidator

  def initialize(opts = {})
    @opts = opts
  end

  def valid_value?(val)
    val.blank? || (val.present? && !(val.include?("http") || val.include?("https") || val.include?(":") || val.include?("/")))
  end

  def error_message
    I18n.t('site_settings.errors.invalid_ipfs_gateway')
  end
end
