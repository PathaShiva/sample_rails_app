class GenerateStatuses < ActiveRecord::Migration[6.1]
  
  class Status < ApplicationRecord
  end

  def change
    Status.create([
      {name: "In Transit"},
      {name: "Out For Delivery"},
      {name: "Failed Delivery Attempt"},
      {name: "Delivered"}
      ])
  end

end
