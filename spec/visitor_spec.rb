require 'spec_helper'

RSpec.describe Visitor do
  describe '#initialize' do
    it 'exists' do
      visitor1 = Visitor.new('Bruce', 54, '$10')

      expect(visitor1).to be_a(Visitor)
    end
  end
end
