require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_enigma_exists
    e = Enigma.new
    assert_instance_of Enigma, e
  end
end
