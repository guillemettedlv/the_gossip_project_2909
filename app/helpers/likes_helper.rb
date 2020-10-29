module LikesHelper
  def like_triplet?(type, type_id)
		if Like.where(user: current_user, likeable_type: type, likeable_id: type_id).exists?
			true
		else
			false
		end  
	end
end
