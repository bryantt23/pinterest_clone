class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, only: [:show, :index]
  
  def index    
    @pins = Pin.all.order("created_at DESC")
  end
  
  def new
    # @pin = Pin.new
    @pin = current_user.pins.build
  end
  
  def create
    # @pin = Pin.new(pin_params)
    @pin = current_user.pins.build(pin_params)
    
    if @pin.save
      redirect_to @pin, notice: "Successfully created new Pin"
    else
      render 'new'
    end
  end
  
  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Pin was successfully updated"
    else
      render 'edit'
    end    
  end
  
  def edit
    
  end
  
  def destroy
    @pin.destroy
      redirect_to root_path
  end
  
  def upvote
    @pin.upvote_by current_user
    redirect_to :back
  end
  
  def show    
  end
  
  private
  
  def pin_params
    params.require(:pin).permit(:title, :description, :image )
  end
  
  def find_pin
    @pin = Pin.find(params[:id])
  end




end
