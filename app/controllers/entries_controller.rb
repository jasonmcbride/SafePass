class EntriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
 

  def index
  @entries    = current_user.entries.search(params[:name])
  @main_entry = @entries.first || current_user.entries.build

  respond_to do |format|
    # Normal HTML/page render
    format.html do
      if turbo_frame_request?
        # Frame request: return the *frame wrapper* and its contents
        render partial: "shared/aside", locals: { entries: @entries }
      else
        render :index
      end
    end

    # Optional turbo stream to patch main-dashboard when there's a single hit
    format.turbo_stream do
      if params[:name].present? && @entries.one?
        render turbo_stream: turbo_stream.update(
          "main-dashboard",
          partial: "entries/entry_form",
          locals: { entry: @entries.first }
        )
      else
        head :ok
      end
    end
  end
end


  def show
  end

  def new
    @entry = current_user.entries.build
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash.now[:notice] = "<strong>#{@entry.name}</strong> has been saved.".html_safe
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream {}
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      flash.now[:notice] = "<strong>#{@entry.name}</strong> has been updated.".html_safe
      respond_to do |format|
        format.html { redirect_to @entry, notice: "Entry updated successfully." }
        format.turbo_stream {}
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    flash.now[:notice] = "<strong>#{@entry.name}</strong> has been deleted.".html_safe
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream {}
    end
  end

  private

  def set_entry
    @entry = current_user.entries.find(params[:id])
  end

  def set_entries
    @entries = current_user.entries.search(params[:name])
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