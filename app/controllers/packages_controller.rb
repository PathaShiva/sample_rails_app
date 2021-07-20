class PackagesController < ApplicationController

  before_action :logged_in_user,:admin_user, only: [:edit, :update,:new,:create]
  before_action :set_package, only: [:edit,:update,:search]

  def home
    @packages =  Package.open_packages
  end

  def index
  end

  def new
    @package = Package.new
    @package.assing_initial_values
  end

  def create
    begin
      Package.transaction do
        @package = Package.new(package_params)
        s_p = Address.create!(sender_address_params)
        r_p = Address.create!(receiver_address_params)
        @package.sender_address_id = s_p.id
        @package.receiver_address_id = r_p.id
        @package.status_id = Status.find_by(name: "In Transit").id
        raise unless @package.save!
        @package.package_updates.create!(location: s_p.address_details)
      end
      flash[:info] = "Package Successfully Created!!!. Tracking Id is #{@package.tracker_id}"
      redirect_to root_path
    rescue => error
      flash[:danger] = error.message
      render :new
    end
  end

  def update
    begin
      @package.update!(update_package_params)
      flash[:info] = "Package Successfully Updated!!!. Tracking Id is #{@package.tracker_id}"
      redirect_to root_path
    rescue => error
      flash[:danger] = error.message
      render :edit
    end
  end

  def search
    if @package.present?
      @package_updates = @package.package_updates.order(id: :desc)
      render :show
    else
      redirect_to root_path
    end
  end

  def edit
  end

  private

  def set_package
    @package = Package.find_by(tracker_id: params[:tracker_id])
    flash[:danger] = "No Data available for the given Tracking Id." if @package.blank?
  end

  def package_params
    params.require(:package).permit(:weight_of_parcel,:cost,:service_type_id,:payment_mode,:tracker_id,:status_id,:sender_email,:receiver_email)
  end

  def update_package_params
    params.require(:package).permit(:status_id)
  end

  def sender_address_params
    params[:package][:sender_address].permit(:name, :mobile, :district, :state, :country, :pincode, :landmark)
  end

  def receiver_address_params
    params[:package][:receiver_address].permit(:name, :mobile, :district, :state, :country, :pincode, :landmark)
  end

end
