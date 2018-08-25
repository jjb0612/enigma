require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require 'simplecov'
SimpleCov.start

class EnigmaTest < Minitest::Test
  def test_enigma_exists
    e = Enigma.new
    assert_instance_of Enigma, e
  end

  def test_it_has_attributes
    e = Enigma.new
    assert_equal "12345", e.key
  end

  def test_key_rotation
    e = Enigma.new
    actual = e.key_rotation("A")
    assert_equal "12", actual

    actual = e.key_rotation("B")
    assert_equal "23", actual

    actual = e.key_rotation("C")
    assert_equal "34", actual

    actual = e.key_rotation("D")
    assert_equal "45", actual

  end

  def test_offset_rotation
    e = Enigma.new
    actual = e.offsets("A")
    assert_equal "0", actual

    actual = e.offsets("B")
    assert_equal "3", actual

    actual = e.offsets("C")
    assert_equal "2", actual

    actual = e.offsets("D")
    assert_equal "4", actual
  end
end
