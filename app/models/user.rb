class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send
  has_many :administrated_events, foreign_key: 'admin_id', class_name: 'Event'
  has_many :attendances, foreign_key: 'attendee_id'
  has_many :joined_events, through: :attendances, source: :event 

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def isAttendeeOf(event)
    self.joined_events.any? { |evt| evt == event }
  end

  def isAdminOf(event)
    self.administrated_events.any? { |evt| evt == event }
  end
end
