class CitiesController < ApplicationController
	def show
		@city = City.find(params[:id])
		@gossips = []
		@city.users.each do |user|
			Gossip.where(user_id: user.id).each do |gossip|
				@gossips << gossip
			end
		end
		#puts "$" * 50
		#puts @gossips
		#puts "$" * 50
	end
end
