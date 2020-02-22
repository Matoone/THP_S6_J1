class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :checkIfCurrentUserIsTheEventAdmin, only: [:index]

  def index
    @event = Event.find(params[:event_id])
  end

  def new
    @event = Event.find(params[:event_id])

  end

  def create
    puts "#" * 300
      event = Event.find(params[:event_id])
      # Amount in cents
    @amount = event.price * 100

    customer = Stripe::Customer.create({
      email: current_user.email,
      source: params[:stripeToken],
    })
    begin
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(event.id)
    end
        flash[:success] = "Votre paiement a fonctionné. Vous êtes bien inscrit à l'évènement #{event.title}"
        attendance = Attendance.create(attendee: current_user, event: event, stripe_customer_id: customer.id )
        redirect_to event_path(event.id)
     
  end


  private

  def checkIfCurrentUserIsTheEventAdmin
    if current_user.isAdminOf(Event.find(params[:event_id])) == false
      flash[:error] = "Vous ne pouvez pas accéder à cette page car vous n'êtes pas l'administrateur de cet évènement."
      redirect_to event_path(params[:event_id])
    end 
  end
end
