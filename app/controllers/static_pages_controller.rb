class StaticPagesController < ApplicationController
  def team
  end
  def contact
  end
  def index
  	@gossips = Gossip.all
  	@indicator_b = 0
  	@indicator_n = 0
  end
end