# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  after_create_commit { broadcast_append_to 'comments' }
  after_update_commit { broadcast_replace_to 'comments' }
  after_destroy_commit { broadcast_remove_to 'comments' }
end
