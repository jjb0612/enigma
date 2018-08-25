require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
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

  def test_total_rotation
    e = Enigma.new
    assert_equal 12, e.total_rotation("A")
    assert_equal 26, e.total_rotation("B")
    assert_equal 36, e.total_rotation("C")
    assert_equal 49, e.total_rotation("D")
  end

  def test_key_index
    e = Enigma.new
    assert_equal ["A","B","C","D","A"], e.key_index("hello")
  end

  def test_message_keys
    e = Enigma.new
    assert_equal [8, 5, 12, 12, 15], e.message_keys("hello")
  end

end
