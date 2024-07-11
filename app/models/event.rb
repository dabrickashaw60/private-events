class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :name, presence: true
  validates :date, presence: true
  validates :location, presence: true

  attribute :location, :string
end
