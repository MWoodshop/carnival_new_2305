class Carnival
  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    # Checks if all riders logs are empty and returns {}
    return {} if @rides.all? { |ride| ride.rider_log.empty? }

    # Otherwise returns the ride with the most riders
    @rides.max_by { |ride| ride.rider_log.values.sum }
  end
end
