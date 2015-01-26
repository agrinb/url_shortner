require 'net/http'
require "uri"

class Url < ActiveRecord::Base
  belongs_to :user
  validate :validate_url
  validates :old_url, presence: true
  validates :short_url, presence: true
  has_many :visits

  def self.random_code
    [*('A'..'Z')].sample(8).join

  end	

  def validate_url
    begin
      uri = URI.parse(old_url)
      resp = uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      resp = false
    end
    unless resp
      errors.add(:old_url, "is not a valid url")
    end
  end
end

