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

  def summary
    visitor_summary = @rides.flat_map do |ride|
      ride.rider_log.map do |visitor, _times_ridden|
        { visitor: visitor, favorite_ride: most_ridden_ride(visitor), total_money_spent: visitor.spending_money }
      end
    end

    ride_summary = @rides.map do |ride|
      { ride: ride, riders: ride.rider_log.keys, total_revenue: ride.total_revenue }
    end

    { visitor_count: visitor_summary.count, revenue_earned: total_revenue, visitors: visitor_summary,
      rides: ride_summary }
  end

  # Helper class method for total_revenue in summary
  def self.total_revenue(carnivals)
    carnivals.sum { |carnival| carnival.total_revenue }
  end

  private

  # Helper instance method for most_ridden_ride in summary
  def most_ridden_ride(visitor)
    @rides.max_by { |ride| ride.rider_log[visitor] || 0 }
  end
end
