require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma_offsets'

class KeyOffSetsTest < Minitest::Test
  def test_key_offsets_exists
    e = OffSets.new
    assert_instance_of OffSets, e
  end

  def test_offset_rotation
    
    e = OffSets.new

    actual = e.offsets("A", "082818")
    assert_equal "1", actual

    actual = e.offsets("B", "082818")
    assert_equal "1", actual

    actual = e.offsets("C", "082818")
    assert_equal "2", actual

    actual = e.offsets("D", "082818")
    assert_equal "4", actual
  end

  def test_last_four_digits_of_date_squared
    e = OffSets.new("082818")
    actual = e.last_four_digits_of_date_squared
    assert_equal ["1", "1", "2", "4"], actual
  end
end
