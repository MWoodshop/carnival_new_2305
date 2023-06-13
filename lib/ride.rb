class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue

  def initialize(ride_info)
    @name = ride_info[:name]
    @min_height = ride_info[:min_height]
    @admission_fee = ride_info[:admission_fee]
    @excitement = ride_info[:excitement]
    @total_revenue = 0
  end
end
