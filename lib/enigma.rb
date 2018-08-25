require 'pry'
require 'date'
class Enigma
  attr_reader :key

  def initialize (key = "12345")
    @key      = key
  end

  def char_map
    {1 => "a",
      2 => "b",
      3 => "c",
      4 => "d",
      5 => "e",
      6 => "f",
      7 => "g",
      8 => "h",
      9 => "i",
      10 => "j",
      11 => "k",
      12 => "l",
      13 => "m",
      14 => "n",
      15 => "o",
      16 => "p",
      17 => "q",
      18 => "r",
      19 => "s",
      20 => "t",
      21 => "u",
      22 => "v",
      23 => "w",
      24 => "x",
      25 => "y",
      26 => "z",
      27 => "1",
      28 => "2",
      29 => "3",
      30 => "4",
      31 => "5",
      32 => "6",
      33 => "7",
      34 => "8",
      35 => "9",
      36 => "0",
      37 => " ",
      38 => ".",
      39 => ","
    }
  end

  def encrypt(message, key, date)

  end

  def key_generator
    rand.to_s[2..6]
  end

  def key_rotation(place)
    key_array = @key.to_s.chars
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

  def offsets(place)
    date = Date.today.strftime("%m%d%y")
    squared = date.to_i ** 2
    squared_array = squared.to_s.chars
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

  def total_rotation(place)
    key_rotation(place).to_i + offsets(place).to_i
  end

  def key_index(message)
    message_array = message.chars
    index_keys = []
    message_array.each_index do |index|
      if index % 4 == 0
        index_keys << "A"
      elsif index % 4 == 1
        index_keys << "B"
      elsif index % 4 == 2
        index_keys << "C"
      elsif index % 4 == 3
        index_keys << "D"
      end
    end
    index_keys
  end

end
