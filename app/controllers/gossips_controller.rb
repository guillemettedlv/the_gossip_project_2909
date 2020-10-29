class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

	def index
  end
  
  def show
  	@gossip = Gossip.find(params[:id])
  	@author = @gossip.user
  	@first_name = @author.first_name
    @comments = Comment.where(gossip_id: params[:id], commentable_type: nil)
    @sub_comments = Comment.where(gossip_id: params[:id], commentable_type: 'Comment')  end

  def new
  	@gossip = Gossip.new
    @tags = Tag.all
  end

  def create
    @tags = Tag.all
  	@gossip = Gossip.new('title' => params[:title], 'content' => params[:content], 'user' => current_user)
    params[:tag].each do |tag|
      tag_interim = Tag.find_by(title: tag)
      @join_table = JoinTableGossipTag.new('gossip' => @gossip, 'tag' => tag_interim)
      @join_table.save
    end
  	if @gossip.save # essaie de sauvegarder en base @gossip
  	  # si ça marche, il redirige vers la page d'index du site
  	  flash[:success] = "Sauvegardé" #hash depuis l'application.html.erb
  	  redirect_to root_path
  	else
  	  # sinon, il render la view new (qui est celle sur laquelle on est déjà)
  	  flash[:danger] = "Non sauvegardé" #idem
  	  render 'new'
  	end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update('title' => params[:title], 'content' => params[:content], 'user' => @gossip.user)
      flash[:success] = "Modification sauvegardée !"
      redirect_to root_path
    else
      flash[:danger] = "Modification non sauvegardée !"
      render :edit
    end
  end
  
  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path
  end

  private 

  def authenticate_user
    unless current_user
      flash[:warning] = "Please log in."
      redirect_to new_session_path
    end
  end
end
