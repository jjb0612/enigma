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


end
