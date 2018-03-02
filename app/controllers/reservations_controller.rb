class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  # before_action :set_car, only: [:index, :show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /reservations
  # GET /reservations.json
  def index
    @all_reservations = Reservation.all
    @reservations = []
    for reservation in @all_reservations
      if reservation.email == current_user.email
        @reservations.push(reservation)
      end
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @@license_no = params[:license_no]
    @@car_id = params[:car_id]
    puts params[:car_id]
    puts params[:license_no]
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    if current_user.customer_role? and current_user.has_reservation
   
      @car = Car.find(@@car_id)
      @car.available?
      # stub end
      redirect_to reservations_url, notice: 'You already have an active reservation!'
    else
      @reservation = Reservation.new(reservation_params)
      @reservation.license_no = @@license_no
      @reservation.email = current_user.email
      @reservation.status = "Reserved"
      @reservation.car_id = @@car_id
      @car = Car.find(@@car_id)

      respond_to do |format|
        if @reservation.save
          @car.update(:status => "Reserved")
          current_user.update(:has_reservation => true)
          format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    # Update car status
    @@car_id = params[:car_id]
    puts params[:car_id]
    @car = Car.find(@@car_id)

    if not current_user.customer_role?
      @reservation.destroy
    else
      puts "STATUS"
      puts params[:status]
      if params[:status] == "Reserved"
        @reservation.update!(:status => "Checked Out")
        @car.update(:status => "Checked Out")
      else
        @reservation.update(:status => "Returned")
        @car.update(:status => "Available")
        current_user.update(:has_reservation => false)
      end
    end
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:car_id, :license_no, :email, :start_time, :end_time, :checkout_time, :status)
    end
end
