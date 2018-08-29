require 'pry'
require 'date'
require './lib/enigma_offsets'
require './lib/key_rotation'

class Enigma
  attr_reader :key,
              :set_date

  def initialize (key = rand.to_s[2..6], set_date = Date.today.strftime("%m%d%y").to_i)
    @key          = key
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

  def rotate_to_abcd (output, set_date = @set_date)
    differences = calculate_difference(output, set_date)
    letters = lettered_keys_for_end_in_output(output)
    if letters[0] == "B"
      differences.rotate(-1)
    elsif letters[0] == "C"
      differences.rotate(-2)
    elsif letters[0] == "D"
      differences.rotate(-3)
    else
      differences
    end
  end

  def calculate_difference(output, set_date = @set_date)
    end_keys = ending_output_shift(output, set_date)
    crack_keys = numbered_keys_for_end_in_output(output, set_date)
    end_keys.map.with_index do |m, i|
      (crack_keys[i] - m)
    end
  end

  def numbered_keys_for_end_in_output(output, set_date = @set_date)
    output_array = output.chars
    last_seven = output_array[-6..-3]
    reverse = char_map.invert
    keys = last_seven.map do |last|
      reverse[last]
    end
  end

  def normal_keys_for_end
    reverse = char_map.invert
    end_array = "..end..".chars
    end_keys = end_array.map do |array|
      reverse[array]
    end
    end_keys[-6..-3]
  end

  def lettered_keys_for_end_in_output(output)
    crack_keys = key_index(output)
    crack_keys[-6..-3]
  end

  def assign_date_keys_to_output(output, set_date = @set_date)
    x = OffSets.new
    get_keys = lettered_keys_for_end_in_output(output)
    date_array = x.last_four_digits_of_date_squared(set_date)
    get_keys.map do |key|
      if key == "A"
        date_array[0]
      elsif key == "B"
        date_array[1]
      elsif key == "C"
        date_array[2]
      elsif key == "D"
        date_array[3]
      end
    end
  end

  def ending_output_shift(output, set_date = @set_date)
    date_keys = assign_date_keys_to_output(output, set_date)
    key_end = normal_keys_for_end
    date_keys.map.with_index do |m, i|
      ((key_end[i]) + m.to_i)
    end
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
    o = OffSets.new
    k = KeyRotation.new
    places.map do |place|
      k.key_rotation(place, key).to_i + o.offsets(place, set_date).to_i
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
