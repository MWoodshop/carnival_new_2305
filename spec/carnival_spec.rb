require 'spec_helper'

RSpec.describe Carnival do
  describe '#initialize' do
    it 'exists' do
      carnival1 = Carnival.new(14)

      expect(carnival1).to be_a(Carnival)
    end
  end
end
