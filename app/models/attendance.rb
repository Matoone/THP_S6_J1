class Attendance < ApplicationRecord
  after_create :attendance_send
  belongs_to :attendee, class_name: 'User'
  belongs_to :event

  def attendance_send
    UserMailer.attendance_email(self.attendee, self.event).deliver_now
  end
end
