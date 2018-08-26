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

    e = Enigma.new("12345", "082518")

    assert_equal "12345", e.key
    assert_equal "082518", e.set_date
  end

  def test_key_rotation

    e = Enigma.new
    actual = e.key_rotation("A", "12345")
    assert_equal "12", actual

    actual = e.key_rotation("B", "12345")
    assert_equal "23", actual

    actual = e.key_rotation("C", "12345")
    assert_equal "34", actual

    actual = e.key_rotation("D", "12345")
    assert_equal "45", actual

  end

  def test_offset_rotation

    e = Enigma.new
    actual = e.offsets("A", "082518")
    assert_equal "0", actual

    actual = e.offsets("B", "082518")
    assert_equal "3", actual

    actual = e.offsets("C", "082518")
    assert_equal "2", actual

    actual = e.offsets("D", "082518")
    assert_equal "4", actual
  end

  def test_total_rotation

    e = Enigma.new
    actual = e.total_rotation(["A", "B", "C", "D"], "12345", "082518")
    assert_equal [12, 26, 36, 49], actual
  end

  def test_key_index

    e = Enigma.new
    assert_equal ["A","B","C","D","A"], e.key_index("hello")
  end

  def test_message_keys

    e = Enigma.new
    assert_equal [8, 5, 12, 12, 15], e.message_keys("hello")
  end

  def test_it_can_get_new_keys

    e = Enigma.new
    expected = e.get_new_encryption_keys("hello", "12345", "082518")
    actual = [20, 31, 9, 22, 27]
    assert_equal actual, expected
  end

  def test_encrypt
    e = Enigma.new
    assert_equal "t5iv1", e.encrypt("hello", "12345", "082518")
    actual = e.encrypt("this is so secret", "12345", "082518")
    assert_equal "68f3j9ph5b83q3oo6", actual
  end

  def test_get_new_decryption_keys
    e = Enigma.new
    actual = e.get_new_decryption_keys("t5iv1", "12345", "082518")
    assert_equal [8, 5, 12, 12, 15], actual
  end

  def test_decrypt
    e = Enigma.new
    actual = e.decrypt("t5iv1", "12345", "082518")
    actual_2 = e.decrypt("68f3j9ph5b83q3oo6", "12345", "082518")
    assert_equal "hello", actual
    assert_equal "this is so secret", actual_2
  end



end
