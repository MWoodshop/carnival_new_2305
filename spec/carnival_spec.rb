require 'spec_helper'

RSpec.describe Carnival do
  describe '#initialize' do
    it 'exists' do
      carnival1 = Carnival.new(14)

      expect(carnival1).to be_a(Carnival)
    end
  end

  describe '#add_ride' do
    it 'can add rides' do
      carnival1 = Carnival.new(14)
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

      carnival1.add_ride(ride1)

      expect(carnival1.rides).to eq([ride1])
    end
  end
end
