require 'date'

class OffSets

  attr_reader :set_date

  def initialize(set_date = Date.today.strftime("%m%d%y"))
    @set_date = set_date
  end

  def last_four_digits_of_date_squared(set_date = @set_date)
    squared = (set_date.to_i) ** 2
    squared.to_s.chars[-4..-1]
  end

  def offsets(place, set_date = @set_date)
    squared_array = last_four_digits_of_date_squared(set_date)
    if place == "A"
      squared_array[-4]
    elsif place == "B"
      squared_array[-3]
    elsif place == "C"
      squared_array[-2]
    elsif place == "D"
      squared_array[-1]
    end
  end

end
