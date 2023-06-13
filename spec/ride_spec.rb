require 'spec_helper'

RSpec.describe Ride do
  describe '#initialize' do
    it 'exists' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

      expect(ride1).to be_a(Ride)
    end
  end
end

