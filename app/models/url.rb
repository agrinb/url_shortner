require 'net/http'
require "uri"

class Url < ActiveRecord::Base
	belongs_to :user
	before_create :validate_url
	validates :old_url, presence: true
	validates :short_url, presence: true


	def validate_url
	  uri = URI.parse(old_url)
	  uri.kind_of?(URI::HTTP)
	rescue URI::InvalidURIError
	  false
	end

	def self.random_code
		[*('A'..'Z')].sample(8).join
	end	

end

