class PackageMailer < ApplicationMailer
    
    def package_updates(package)
        @package = package
        mail to: [package.sender_email,package.receiver_email], subject: "Courier Updates"
    end
end
