class Plane 

def take_off
  raise "Plane cannot take off: not in airport"
end

def airport
  raise "Plane cannot be at an airport: plane is already flying"
end

end