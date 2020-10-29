class CommentablePoly < ActiveRecord::Migration[5.2]
  def change
  	add_reference :comments, :commentable, polymorphic: true
  	add_index :comments, [:commentable_id, :commentable_type]
  end
end
