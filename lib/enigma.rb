require 'pry'
require 'date'

class Enigma
  attr_reader :key,
              :set_date

  def initialize (key = rand.to_s[2..6], set_date = Date.today.strftime("%m%d%y"))
    @key      = key
    @set_date     = set_date
  end

  def encrypt(message, key = @key, set_date = @set_date)
    keys = get_new_encryption_keys(message, key, set_date)
    keys.map do |key|
      char_map[key]
    end.join
  end

  def decrypt(message, key = @key, set_date = @set_date)
    keys = get_new_decryption_keys(message, key, set_date)
    keys.map do |key|
      char_map[key]
    end.join
  end

  def crack(output, set_date = @set_date)
    output_array = output.chars
    last_seven = output_array[-7..-1]
    reverse = char_map.invert
    keys = last_seven.map do |last|
      reverse[last]
    end
    keys
  end

  def keys_for_end
    reverse = char_map.invert
    end_array = "..end..".chars
    end_keys = end_array.map do |array|
      reverse[array]
    end
    end_keys
  end

  def get_new_encryption_keys(message, key, set_date)
    coded_index = key_index(message)
    rotation = total_rotation(coded_index, key, set_date)
    mapped_keys = message_keys(message)
    rotation.map.with_index do |m, i|
      (m + mapped_keys[i].to_i) % 39
    end
  end

  def get_new_decryption_keys(message, key, set_date)
    coded_index = key_index(message)
    rotation = total_rotation(coded_index, key, set_date)
    mapped_keys = message_keys(message)
    rotation.map.with_index do |m, i|
      (mapped_keys[i].to_i - m) % 39
    end
  end

  def total_rotation(places, key, set_date)
    places.map do |place|
      key_rotation(place, key).to_i + offsets(place, set_date).to_i
    end
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

  def message_keys(message)
    character_array = message.chars
    reverse = char_map.invert
    character_array.map do |character|
      index = reverse [character]
    end
  end

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

  def offsets(place, set_date)
    squared = set_date.to_i ** 2
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


  binding.pry
end
