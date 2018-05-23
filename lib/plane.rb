class Plane 

  def initialize
    @flying = true
  end

  def take_off
    raise "Plane cannot take off: not in airport"
  end

  def airport
    raise "Plane cannot be at an airport: plane is already flying"
  end

  def land(airport)
    raise "Plane cannot land, plane already landed" unless @flying
    @flying = false
  end

end

# i want to access an instance variable set in initialiser from a method inside the instance 