class EventsController < ApplicationController
    before_action :authorize, except: [:index, :show]

    def index 
        @events = Event.all
        if params[:category]
            @events = Event.where(category: params[:category]).order("created_at DESC")
          else
            @events = Event.all.order("created_at DESC")
          end
    end
    
    def new 
        @event = Event.new
    end 

    def create 
        @event = Event.new(event_params)
        @event.user = current_user
        if event_params.has_key?("image") && @event.save
            redirect_to event_path(@event)
        else 
        flash[:upload_image_notice] = "Please upload image"
            redirect_to new_event_path
        end 
    end
    
    def show 
        @event = Event.find(params[:id])
        @comment = Comment.new
    end 

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        @event.update_attributes(event_params)
        redirect_to event_path(@event)
    end 

    def destroy 
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_path 
    end 

    private 
     
        def event_params
            params.require(:event).permit(:name, :location, :description, :category, :time, :image)
        end 

end