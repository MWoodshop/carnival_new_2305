require 'spec_helper'

RSpec.describe Carnival do
  before(:each) do
    @carnival1 = Carnival.new(14)
    @carnival2 = Carnival.new(7)
    @carnival3 = Carnival.new(10)

    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')

    @carnival1.add_ride(@ride1)
    @carnival1.add_ride(@ride2)
    @carnival1.add_ride(@ride3)

    @carnival2.add_ride(@ride1)

    @carnival3.add_ride(@ride1)
    @carnival3.add_ride(@ride2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@carnival1).to be_a(Carnival)
    end
  end

  describe '#add_ride' do
    it 'can add rides' do
      expect(@carnival1.rides).to eq([@ride1, @ride2, @ride3])
    end
  end

  describe '#most_popular_ride' do
    it 'can find the most popular ride' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)

      expect(@carnival1.most_popular_ride).to eq(@ride1)
    end

    it 'will return {} if rider_log is empty' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)

      @ride2.board_rider(@visitor1)

      expect(@carnival1.most_popular_ride).to eq({})
    end
  end

  describe '#most_profitable_ride' do
    it 'can find the most profitable ride' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)

      expect(@carnival1.most_profitable_ride).to eq(@ride2)
    end

    it 'will return {} if all rides have total_revenue = 0' do
      expect(@carnival1.most_profitable_ride).to eq({})
    end
  end

  describe 'total_revenue' do
    it 'can calculate total revenue' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)

      expect(@carnival1.total_revenue).to eq(7)
    end

    it 'will return {} if carnival (the rides) have no revenue' do
      expect(@carnival1.total_revenue).to eq({})
    end
  end

  describe '#summary' do
    it 'returns a hash with the correct keys' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      summary = @carnival1.summary

      expect(summary.keys).to contain_exactly(:visitor_count, :revenue_earned, :visitors, :rides)
    end

    it 'returns correct visitor_count' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      summary = @carnival1.summary

      expect(summary[:visitor_count]).to eq(4)
    end

    it 'returns correct total_revenue' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      summary = @carnival1.summary

      expect(summary[:revenue_earned]).to eq(9)
    end

    it 'returns correct visitor summary' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      summary = @carnival1.summary
      visitor_summary = summary[:visitors]

      expect(visitor_summary).to include(a_hash_including(visitor: @visitor1, favorite_ride: @ride1,
                                                          total_money_spent: 4))
    end

    it 'returns correct ride summary' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)

      summary = @carnival1.summary

      ride_summary = summary[:rides]
      expect(ride_summary).to include(a_hash_including(ride: @ride1, riders: [@visitor1, @visitor2], total_revenue: 2))
      expect(ride_summary).to include(a_hash_including(ride: @ride2, riders: [@visitor1], total_revenue: 5))
      expect(ride_summary).to include(a_hash_including(ride: @ride3, riders: [@visitor3], total_revenue: 2))
    end

    it 'returns correct total_revenue on multiple carnivals' do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride3.board_rider(@visitor3)
      total_revenue = Carnival.total_revenue([@carnival1, @carnival2, @carnival3])

      expect(total_revenue).to eq(18)
    end
  end
end
