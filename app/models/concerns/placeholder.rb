module Placeholder
	extend ActiveSupport::Concern

	def self.image_generator(height:, width:)
		"https://placeholdit.com/#{height}x#{width}"
	end
end