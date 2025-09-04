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
      flash[:notice] = "Entry has been saved."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error saving the entry."
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
  end

  def entry_params
    params.expect(entry: [:name, :url, :username, :password])
  end
end