# frozen_string_literal: true

require 'action_view'

# no-doc
class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  after_create_commit { broadcast_append_to 'comments' }
  after_update_commit { broadcast_replace_to 'comments' }
  after_destroy_commit { broadcast_remove_to 'comments' }

  def created_time_ago
    time_ago_in_words(created_at)
  end
end
