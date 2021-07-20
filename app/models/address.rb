class Address < ApplicationRecord
    validates :name, :mobile, :district, :state, :country, :pincode, presence: true
    has_one :package

    def address_details
        "#{district},#{state},#{country},#{pincode}"
    end
end
