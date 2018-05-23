require 'plane'

describe Plane do
  describe '#take_off' do
    it 'should respond to #take_off' do
      expect(subject).to respond_to :take_off
    end

    it 'raises an error if already flying' do
      expect { subject.take_off }.to raise_error "Plane cannot take off: not in airport"
    end
  end

end

# I'm expecting the error 'plane cannot take off, not in the aiport' but I'm 
# gettig undefined method for nil
# I think the nil is coming from my 