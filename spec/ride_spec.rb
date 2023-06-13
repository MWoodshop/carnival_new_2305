require 'spec_helper'

RSpec.describe Ride do
  describe '#initialize' do
    it 'exists' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })

      expect(ride1).to be_a(Ride)
    end

    it 'has attributes' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      expect(ride1.name).to eq('Carousel')
      expect(ride1.min_height).to eq(24)
      expect(ride1.admission_fee).to eq(1)
      expect(ride1.excitement).to eq(:gentle)
      expect(ride1.total_revenue).to eq(0)
      expect(ride1.rider_log).to eq({})
    end
  end

  describe '#board_rider' do
    it 'can board a rider' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)

      ride1.board_rider(visitor1)
      expect(ride1.rider_log).to eq({ visitor1 => 1 })
    end

    it 'will not board a rider if they are not tall enough' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 64, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor1.add_preference(:gentle)

      ride1.board_rider(visitor1)

      expect(ride1.rider_log).to eq({})
    end

    it 'will not board a rider if they do not have a matching preference' do
      ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor1.add_preference(:gentle)
      visitor2.add_preference(:gentle)

      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)
    end
  end
end
