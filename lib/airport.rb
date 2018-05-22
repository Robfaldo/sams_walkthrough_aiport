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

  end

  private

  def full?
    @planes.length >= @capacity 
  end

  def stormy?
    rand(10) < 9
  end

end
