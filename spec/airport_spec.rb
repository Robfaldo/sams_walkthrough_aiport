require 'airport'
require 'plane'

describe Airport do 
  subject(:airport) { described_class.new(20, weather_reporter) }
  let(:plane) { double :plane }
  let(:weather_reporter) { double :weather_reporter }


  describe "#land" do
    context 'when not stormy' do

      before do
        allow(weather_reporter).to receive(:stormy?).and_return(false)
      end

      it 'is expected to respond to land with 1 argument' do
        expect(airport).to respond_to(:land).with(1).argument
      end 

      context 'full' do 
        it 'does not allow landing when at capacity' do
           20.times { airport.land(:plane) }
           expect { airport.land(:plane) }.to raise_error "Can't land plane, airport is full"
        end
      end

      it 'is expected to respond to land with 1 argument' do
        allow(weather_reporter).to receive(:stormy?).and_return(false)
        expect(airport).to respond_to(:land).with(1).argument
      end 
    end

    context 'when stormy' do 
      it 'raises an error if asked to land a plane when stormy' do
        allow(weather_reporter).to receive(:stormy?).and_return(true)
        expect { airport.land(plane) }.to raise_error "Can't land plane in stormy weather"
      end
    end
  end

  describe "#take_off" do
    describe 'when stormy' do
      before do 
        allow(airport).to receive(:stormy?).and_return(true)
      end

      it 'raises an error if asked to take off a plane when stormy' do
        expect { airport.take_off(plane) }.to raise_error "Can't take off plane in stormy weather"
      end
    end

    it 'so that planes can take off, it responds to take off with the plane to take off' do
      expect(airport).to respond_to(:take_off).with(1).argument
    end
  end

end

