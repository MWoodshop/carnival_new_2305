require 'spec_helper'

RSpec.describe Carnival do
  before(:each) do
    @carnival1 = Carnival.new(14)
    @carnival2 = Carnival.new(7)

    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')

    @carnival1.add_ride(@ride1)
    @carnival1.add_ride(@ride2)
    @carnival1.add_ride(@ride3)
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
  end
end
