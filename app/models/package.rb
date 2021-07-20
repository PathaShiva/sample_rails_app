class Package < ApplicationRecord

    has_many :package_updates
    belongs_to :service_type
    belongs_to :status
    belongs_to :sender_address, class_name: "Address", foreign_key: "sender_address_id"
    belongs_to :receiver_address, class_name: "Address", foreign_key: "receiver_address_id"
    belongs_to :user, optional: true
    validates :weight_of_parcel,:cost,:payment_mode,:tracker_id, presence: true
    validate :validate_payment_mode, on: :before_save
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :sender_email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX }
    validates :receiver_email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX }
    after_save :send_email

    def self.open_packages
        Package.where.not(status_id: Status.find_by(name: "Delivered").id).limit(20).includes(:sender_address,:receiver_address,:status,:service_type).order(id: :desc)
    end

    def generate_token
        self.tracker_id = "CAP#{SecureRandom.alphanumeric(15)}"
    end

    def assing_initial_values
        self.status_id = Status.find_by(name: "In Transit").id
        generate_token
    end

    def validate_payment_mode
        errors.add(:payment_mode,"Invalid") unless ["COD","Prepaid"].include? payment_mode
    end

    def send_email
        PackageMailer.package_updates(self).deliver_now
    end

end
