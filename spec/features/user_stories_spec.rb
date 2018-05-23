describe 'User Stories' do

  let(:airport) { Airport.new(20, weather_reporter) }
  let(:plane) {Plane.new}
  let(:weather_reporter) { WeatherReporter.new }

  context 'when not stormy' do 
    before do 
      allow(weather_reporter).to receive(:stormy?).and_return(false)
    end
    # As an air traffic controller
    # So planes can land safely at my airport 
    # I would like to instruct a plane to land 
    it 'planes land at airports, instruct a plane to land' do
      expect { airport.land(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So planes can take off safely from an airport
    # I would like to instruct a plane to take off 
    it 'planes can take off from an airport' do
      airport.land(plane)
      expect { airport.take_off(plane) }.not_to raise_error
    end

    context 'when airport is full' do 
      # As an air traffic controller
      # So that I can avoid colissions 
      # I want to prevent airplanes landing when my airport is full 
      it 'does not allow planes to land' do
        20.times { airport.land(plane) }
        expect { airport.land(plane) }.to raise_error "Can't land plane, airport is full"
      end
    end

    # As an air traffic controller 
    # So that I can ensure safe take off procedures 
    # I want planes only to take off from the airport they are at 
    it 'planes only take off from the airport they are at' do
      airport_2 = Airport.new(20, WeatherReporter.new)
      allow(airport_2).to receive(:stormy?).and_return(false)
      airport_2.land(plane)
      expect { airport.take_off(plane) }.to raise_error "This plane is not as this location"
    end
  end

  context 'when stormy' do 
    before do 
     allow(weather_reporter).to receive(:stormy?).and_return(false)
    end
    # As an air traffic controller
    # So that i can avoid accident 
    # I want to prevent planes from landing or taking off when the weather is stormy 
    it 'does not allow planes to land' do
      airport.land(plane)
      allow(weather_reporter).to receive(:stormy?).and_return(true)
      expect { airport.land(plane) }.to raise_error "Can't land plane in stormy weather"
    end
    it 'does not allow planes to take off' do
      airport.land(plane)
      airport.take_off(plane)
      allow(weather_reporter).to receive(:stormy?).and_return(true)
      expect { airport.take_off(plane) }.to raise_error "Can't take off plane in stormy weather"
    end
  end
end