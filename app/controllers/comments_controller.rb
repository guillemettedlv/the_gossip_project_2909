class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
	def show
  	@gossip = Gossip.find(params[:gossip_id])
  	@comment = Comment.find(params[:id])
  end
  def new
  	@gossip = Gossip.find(params[:gossip_id])
  	@comment = Comment.new
  end
  def create
  	#@user = User.find_by(first_name: "Anonymous")
  	@gossip = Gossip.find(params[:gossip_id])
  	@comment = Comment.new('content' => params[:content], 'user' => current_user, 'gossip' => @gossip)
  	if @comment.save # essaie de sauvegarder en base @gossip
  	  # si ça marche, il redirige vers la page d'index du site
  	  flash[:success] = "Oh le beau commentaire !" #hash depuis l'application.html.erb
  	  redirect_to root_path
  	else
  	  # sinon, il render la view new (qui est celle sur laquelle on est déjà)
  	  flash[:danger] = "Meh sans contenu c'est pas un commentaire" #idem
  	  render 'new'
  	end
  end
  def edit
  	@gossip = Gossip.find(params[:gossip_id])
  	@comment = Comment.find(params[:id])
  end
  def update
  	@comment = Comment.find(params[:id])
  	if @comment.update('content' => params[:content], 'user' => @comment.user, 'gossip' => @comment.gossip)
  	  # si ça marche, il redirige vers la page d'index du site
  	  flash[:success] = "Update bien pris en base" #hash depuis l'application.html.erb
  	  redirect_to gossip_path(@comment.gossip.id)
  	else
  	  # sinon, il render la view new (qui est celle sur laquelle on est déjà)
  	  flash[:danger] = "edite un commentaire, c'est pas facile" #idem
  	  render :edit
  	end
  end
  def destroy
  	@comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

  private 

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end
