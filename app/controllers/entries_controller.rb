class EntriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_entries, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_main_entry, only: [:index]

  def index
  end

  def show
    @entry = current_user.entries.find(params[:id])
  end

  def new
    @entry = current_user.entries.build
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash.now[:notice] = "<strong>#{@entry.name}</strong> has been saved.".html_safe
      respond_to do |format|
        format.html { redirect_to @entry }
        format.turbo_stream {}
      end
    
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end

  def update
    @entry = current_user.entries.find(params[:id])
    if @entry.update(entry_params)
      redirect_to @entry, notice: "Entry updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    redirect_to entries_path, notice: "Entry deleted successfully."
  end

  private

  def set_entries
    @entries = current_user.entries
  end

  def set_main_entry
    @main_entry = current_user.entries.first
    if @main_entry.nil?
      @main_entry = current_user.entries.build
    end
  end

  def entry_params
    params.expect(entry: [:name, :url, :username, :password])
  end
end