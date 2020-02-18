class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
    p "#"*60
    p @event
    p "#"*60
  end

  def new
    @event = Event.new
  end

  def create
    puts "#"*60
    puts params
    puts "#"*60
    event_params = params.require(:event).permit(:title, :location, :duration, :start_date, :description, :price)
    event = Event.new(event_params)
    event.admin = current_user
    if event.save
      puts "#"*60
    puts "succeesss"
    puts "#"*60
      flash[:success]="Votre évènement a bien été créé"
      redirect_to event_path(event.id)
    else
      puts "#"*60
    puts "faaaail"
    puts "#"*60
    @errors = event.errors
    render :new
    end
    #gossip_params = params.require(:gossip).permit(:title, :content)
  end
end
