require Rails.root + 'lib/net_http_purge'

class SlowThingsController < ApplicationController
  respond_to :html
  before_action :set_slow_thing, only: [:show, :edit, :update, :destroy]

  # GET /slow_things
  # GET /slow_things.json
  def index
    @slow_things = SlowThing.all
    respond_with @slow_things if stale? @slow_things, public: true
  end

  # GET /slow_things/1
  # GET /slow_things/1.json
  def show
    respond_with @slow_thing if stale? @slow_thing, public: true
  end

  # GET /slow_things/new
  def new
    @slow_thing = SlowThing.new
  end

  # GET /slow_things/1/edit
  def edit
  end

  # POST /slow_things
  # POST /slow_things.json
  def create
    @slow_thing = SlowThing.new(slow_thing_params)

    respond_to do |format|
      if @slow_thing.save

        domain = URI(root_url)
        Net::HTTP.start(domain.host, domain.port) do |http|
          Rails.logger.debug "purging #{domain}"
          http.request( Purge.new(domain) )

          Rails.logger.debug "purging #{slow_things_url}"
          http.request( Purge.new(URI(slow_things_url)) )
        end

        format.html { redirect_to @slow_thing, notice: 'Slow thing was successfully created.' }
        format.json { render :show, status: :created, location: @slow_thing }
      else
        format.html { render :new }
        format.json { render json: @slow_thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slow_things/1
  # PATCH/PUT /slow_things/1.json
  def update
    respond_to do |format|
      if @slow_thing.update(slow_thing_params)

        domain = URI(root_url)
        Net::HTTP.start(domain.host, domain.port) do |http|
          Rails.logger.debug "purging #{domain}"
          http.request( Purge.new(domain) )

          Rails.logger.debug "purging #{slow_things_url}"
          http.request( Purge.new(URI(slow_things_url)) )

          Rails.logger.debug "purging #{slow_thing_url(@slow_thing)}"
          http.request( Purge.new(URI(slow_thing_url(@slow_thing))) )
        end

        format.html { redirect_to @slow_thing, notice: 'Slow thing was successfully updated.' }
        format.json { render :show, status: :ok, location: @slow_thing }
      else
        format.html { render :edit }
        format.json { render json: @slow_thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slow_things/1
  # DELETE /slow_things/1.json
  def destroy
    @slow_thing.destroy
    respond_to do |format|
      format.html { redirect_to slow_things_url, notice: 'Slow thing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slow_thing
      @slow_thing = SlowThing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slow_thing_params
      params.require(:slow_thing).permit(:name)
    end
end
