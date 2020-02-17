class Event < ApplicationRecord
  validates :start_date, presence: true # +custom validation only > Time.now
  validates :duration, presence: true, numericality: { only_integer: true } # + custom validate number % 5 == 0 et positif
  validates :title, presence: true, length: {minimum: 5, maximum: 140}
  validates :description, presence: true, length: {minimum: 20, maximum: 1000}
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000 }
  validates :location, presence: true
  has_many :attendances
  has_many :attendees, through: :attendances, class_name: 'User'
  belongs_to :admin, class_name: 'User'
end