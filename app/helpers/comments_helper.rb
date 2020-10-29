module CommentsHelper
  def likes_comment_number(comment_id)
  	Like.where(likeable_type: 'Comment', likeable_id: comment_id).size
  end
end
