class Airport 

  def initialize(capacity)
    @capacity = capacity
    @planes = []
  end

  def land(plane)
    raise  "Can't land plane, airport is full" if full?
    raise "Can't land plane in stormy weather" if stormy?
    @planes << plane
  end

  def take_off(plane)
    raise "Can't take off plane in stormy weather" if stormy?
  end

  private

  def full?
    @planes.length >= @capacity 
  end

  def stormy?
    rand(10) < 9
  end

end

# When the method call 'take_off(plane)' is called on an instance of the Airport class, I want it to fail if it is stormy