class Credential < ActiveRecord::Base
  attr_accessible :secret_token, :uuid
  validates_presence_of :secret_token, :uuid
  validates_uniqueness_of :uuid

  def self.authenticated?(uuid, secret_token)
    uuid_secret_token_pair = where(:uuid => uuid, :secret_token => secret_token).first
    uuid && secret_token && uuid_secret_token_pair.present? ? true : false
  end
end
