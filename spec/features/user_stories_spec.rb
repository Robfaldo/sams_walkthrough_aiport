describe 'User Stories' do

  let(:airport) { Airport.new(weather_reporter, 20) }
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
      expect(airport).to respond_to :take_off
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

    context 'take off' do
      # As an air traffic controller 
      # So that I can ensure safe take off procedures 
      # I want planes only to take off from the airport they are at 
      it 'planes only take off from the airport they are at' do
        airport_2 = Airport.new(weather_reporter, 20)
        allow(airport_2).to receive(:stormy?).and_return(false)
        airport_2.land(plane)
        expect { airport.take_off(plane) }.to raise_error "This plane is not as this location"
      end

      # As an air traffic controller 
      # So the system is consistent and correctly reports plane status and location 
      # I want to ensure a flying plane cannot take off and cannot be in an airport 
      it 'flying planes cannot take off' do
        new_airport = Airport.new(weather_reporter)
        new_airport.land(plane)
        flying_plane = new_airport.take_off(plane)      
        expect { flying_plane.take_off }.to raise_error "Plane cannot take off: not in airport"
      end

      it 'flying planes cannot be in an airport' do
        airport.land(plane)
        flying_plane = airport.take_off(plane)
        expect { flying_plane.airport }.to raise_error "Plane cannot be at an airport: plane is already flying"
      end
    end

    # As a system designer 
    # So that the software cna be used for many different airports
    # I would like a default capcity that can be overridden as appropriate
    it 'has a default capacity is none is specified' do 
      default_airport = Airport.new(weather_reporter)
      Airport::DEFAULT_CAPACITY.times { default_airport.land(plane) }
      expect {default_airport.land(plane) }.to raise_error "Can't land plane, airport is full"
    end


    # As an air traffic controller 
    # So the system is consistent and correctly reports plane status and location
    # I want to ensure a plane that is not flying cannot land and must be in an airport
    it 'non-flying planes cannot land' do
      airport.land(plane)
      expect { plane.land }.to raise_error "Plane cannot land, plane already landed"
    end

    xit 'non-flying planes must be in an airport' do
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