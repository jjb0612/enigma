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
end
