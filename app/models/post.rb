# frozen_string_literal: true

require 'action_view'

# no-doc
class Post < ApplicationRecord
  include ActionView::Helpers::DateHelper

  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def created_time_ago
    time_ago_in_words(created_at)
  end
end
