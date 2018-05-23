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

  describe '#airport' do
    let(:airport) { double :airport}
    it { is_expected.to respond_to :airport } 

    it 'raises an error if already flying' do
      allow(airport).to receive(:take_off).and_return [Plane.new]
      flying_plane = airport.take_off(subject)
      expect { subject.airport }.to raise_error "Plane cannot be at an airport: plane is already flying"
    end
  end

  describe '#land' do
    it { is_expected.to respond_to :land }

    it 'raises an error if already landed' do
      subject.land
      expect { subject.land }.to raise_error "Plane cannot land, plane already landed"
    end
  end

end

# I'm expecting the error 'plane cannot take off, not in the aiport' but I'm 
# gettig undefined method for nil
# I think the nil is coming from my 