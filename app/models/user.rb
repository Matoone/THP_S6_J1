class User < ApplicationRecord
  after_create :welcome_send
  has_many :administrated_events, foreign_key: 'admin_id', class_name: 'Event'
  has_many :joined_events, through: :attendances, foreign_key: 'event_id', class_name: 'Event'

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end