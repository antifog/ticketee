class TicketsController < ApplicationController
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]

  def show
    @states = State.all
  end

  def new
    @ticket = @project.tickets.build
    @states = State.all
  end

  def create
    @ticket = @project.tickets.build(params[:ticket])
    @states = State.all
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render :action => "new"
    end
  end

  def edit
    @states = State.all
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been updated."
      @states = State.all
      render :action => "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."
    redirect_to @project
  end

  private
    def find_project
      @project = Project.find(params[:project_id])
    end

    def find_ticket
     @ticket = @project.tickets.find(params[:id])
    end
end
