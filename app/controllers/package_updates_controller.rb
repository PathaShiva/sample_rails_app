class PackageUpdatesController < ApplicationController

  before_action :logged_in_user,:admin_user, only: [:new,:create]
  before_action :set_package

  def new
    if @package.present?
      @package_update = @package.package_updates.new
    else
      redirect_to root_path
    end
  end

  def create
    if @package.present?
      @package_update = @package.package_updates.new(package_update_params)
      if @package_update.save!
        flash[:info] = "Package Update Successfully Created!!!. Tracking Id is #{@package.tracker_id}"
        redirect_to root_path
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  private

  def package_update_params
    params.require(:package_update).permit(:location,:details)
  end

  def set_package
    @package = Package.find_by(tracker_id: params[:tracker_id])
    flash[:danger] = "No Data available for the given Tracking Id." if @package.blank?
  end

end