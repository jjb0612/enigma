require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_rotation'

class KeyRotationTest < Minitest::Test

  def test_key_rotation_exists
    k = KeyRotation.new
    assert_instance_of KeyRotation, k
  end

  def test_key_rotation
    e = KeyRotation.new

    actual = e.key_rotation("A", "12345")
    assert_equal "12", actual

    actual = e.key_rotation("B", "12345")
    assert_equal "23", actual

    actual = e.key_rotation("C", "12345")
    assert_equal "34", actual

    actual = e.key_rotation("D", "12345")
    assert_equal "45", actual
  end


end
