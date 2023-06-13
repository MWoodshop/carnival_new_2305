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
  end

  describe '#initialize' do
    it 'exists' do
      expect(@carnival1).to be_a(Carnival)
    end
  end

  describe '#add_ride' do
    it 'can add rides' do
      @carnival1 = Carnival.new(14)
      @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

      @carnival1.add_ride(@ride1)

      expect(@carnival1.rides).to eq([@ride1])
    end
  end

  describe '#most_popular_ride' do
    it 'can find the most popular ride' do
    end
  end
end
