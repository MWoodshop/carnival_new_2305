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
    # Checks if all rider_logs are empty and returns {}
    return {} if @rides.all? { |ride| ride.rider_log.empty? }

    # Otherwise returns the ride with the most riders
    @rides.max_by { |ride| ride.rider_log.values.sum }
  end

  def most_profitable_ride
    # Checks if all ride total_revenue are 0 and returns {}
    return {} if @rides.all? { |ride| ride.total_revenue.zero? }

    # Otherwise return the ride with the most total_revenue
    @rides.max_by { |ride| ride.total_revenue }
  end

  def total_revenue
    # Checks if all ride total_revenue are 0 and returns {}
    return {} if @rides.all? { |ride| ride.total_revenue.zero? }

    @rides.sum { |ride| ride.total_revenue }
  end
end
