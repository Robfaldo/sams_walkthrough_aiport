class Airport 

  DEFAULT_CAPACITY = 20 

  def initialize(weather_reporter, capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @weather_reporter = weather_reporter
    @planes = []
  end

  def land(plane)
    raise  "Can't land plane, airport is full" if full?
    raise "Can't land plane in stormy weather" if stormy?
    @planes << plane
  end

  def take_off(plane)
    raise "Can't take off plane in stormy weather" if stormy?
    raise "This plane is not as this location" unless @planes.include?(plane)
    plane
  end

  private

  def full?
    @planes.length >= @capacity 
  end

  def stormy?
    @weather_reporter.stormy?
  end

end

# I want to call a message on an instance of the WeatherReporter class, 
# which will return true or false 