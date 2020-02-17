class Event < ApplicationRecord
  validates :start_date, presence: true # +custom validation only > Time.now
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 } # + custom validate number % 5 == 0 et positif
  validates :title, presence: true, length: {minimum: 5, maximum: 140}
  validates :description, presence: true, length: {minimum: 20, maximum: 1000}
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000 }
  validates :location, presence: true
  validate start_date_cannot_be_in_the_past
  validate duration_must_be_multiple_of_5
  has_many :attendances
  has_many :attendees, through: :attendances, class_name: 'User'
  belongs_to :admin, class_name: 'User'

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < DateTime.now
      errors.add(:start_date, "ne peut pas être dans le passé!")
    end
  end

  def duration_must_be_multiple_of_5
    if duration.present? && duration % 5 != 0
      errors.add(:duration, "doit être multiple de 5")
    end
  end
end
