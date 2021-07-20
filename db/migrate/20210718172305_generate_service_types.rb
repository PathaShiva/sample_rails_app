class GenerateServiceTypes < ActiveRecord::Migration[6.0]
  
  class ServiceTypes < ApplicationRecord
  end

  def change
    ServiceTypes.create([
      {name: "Speed Post"},
      {name: "Regular"}
      ])
  end
end
