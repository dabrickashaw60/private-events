class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :attendances
  has_many :attendees, through: :attendances, source: :attendee

  scope :past, -> { where('date < ?', Date.today) }
  scope :upcoming, -> { where('date >= ?', Date.today) }

  validates :name, presence: true
  validates :date, presence: true
  validates :location, presence: true

  attribute :location, :string
end
