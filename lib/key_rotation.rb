class KeyRotation

  def key_rotation(place, key)
    key_array = key.to_s.chars
    if place == "A"
      key_array[0] + key_array[1]
    elsif place == "B"
      key_array[1] + key_array[2]
    elsif place == "C"
      key_array[2] + key_array[3]
    elsif place == "D"
      key_array[3] + key_array[4]
    end
  end

end
