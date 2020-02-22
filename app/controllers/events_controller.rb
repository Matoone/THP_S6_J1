class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :checkIfCurrentUserIsTheEventAdmin, only: [:edit, :update, :destroy]
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
    
  end

  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:title, :location, :duration, :start_date, :description, :price)
    event = Event.new(event_params)
    event.admin = current_user
    if event.save
  
      flash[:success]="Votre évènement a bien été créé"
      redirect_to event_path(event.id)
    else
   
    @errors = event.errors
    @event = Event.new
    render :new
    end
    #gossip_params = params.require(:gossip).permit(:title, :content)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event_params = params.require(:event).permit(:title, :location, :duration, :start_date, :description, :price)
    event.attributes = event_params
    if event.save
      flash[:success]="Votre évènement a bien été modifié"
      redirect_to event_path(event.id)
    else
      @errors = event.errors
      @event = Event.find(params[:id])
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    Event.destroy(event.id)
    flash[:success]= "Votre évènement a bien été supprimé"
    redirect_to events_path
  end


  private

  def checkIfCurrentUserIsTheEventAdmin
    if current_user.isAdminOf(Event.find(params[:id])) == false
      flash[:error] = "Vous ne pouvez pas accéder à cette page car vous n'êtes pas l'administrateur de cet évènement."
      redirect_to event_path(params[:id])
    end 
  end
end
