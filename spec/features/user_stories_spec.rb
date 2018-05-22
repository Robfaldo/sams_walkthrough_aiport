describe 'User Stories' do

  # As an air traffic controller
  # So planes can land safely at my airport 
  # I would like to instruct a plane to land 
  it 'so plans land at airports, instruct a plane to land' do
    airport = Airport.new(20)
    plane = Plane.new
    allow(airport).to receive(:stormy?).and_return(false)
    expect { airport.land(plane) }.not_to raise_error
  end

  # As an air traffic controller
  # So planes can take off safely from an airport
  # I would like to instruct a plane to take off 
  it 'so that planes can take off from an airport' do
    airport = Airport.new(2)
    plane = Plane.new
    allow(airport).to receive(:stormy?).and_return(false)
    expect { airport.take_off(plane) }.not_to raise_error
  end

  # As an air traffic controller
  # So that I can avoid colissions 
  # I want to prevent airplanes landing when my airport is full 
  it 'so that no planes collide, it prevents airplanes landing when airport is full' do
    airport = Airport.new(20) # create airport with capacity of 20 
    plane = Plane.new 
    allow(airport).to receive(:stormy?).and_return(false)
    20.times { airport.land(plane) }
    expect { airport.land(plane) }.to raise_error "Can't land plane, airport is full"
  end

  # As an air traffic controller
  # So that i can avoid accident 
  # I want to prevent planes from landing or taking off when the weather is stormy 
  it 'prevents planes from landing when the weather is stormy' do
    airport = Airport.new(20) 
    plane = Plane.new
    allow(airport).to receive(:stormy?).and_return(false)
    airport.land(plane)
    allow(airport).to receive(:stormy?).and_return(true)
    expect { airport.land(plane) }.to raise_error "Can't land plane in stormy weather"
  end


end