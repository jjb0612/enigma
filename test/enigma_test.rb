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

  def test_numbered_keys_end_in_output
    e = Enigma.new("12345")
    output = "0. f3ndb395donph9f83u7oo029iueaio"
    output_1 = "o3bxt39"
    expected_1 = [29, 2, 24, 20]
    expected = [9, 21, 5, 1]
    actual_1 = e.numbered_keys_for_end_in_output(output_1)
    actual = e.numbered_keys_for_end_in_output(output)
    assert_equal expected, actual
    assert_equal expected_1, actual_1
  end

  def test_normal_keys_for_end
    e = Enigma.new
    x = Enigma.new("12345")
    expected = [38, 5, 14, 4]
    actual = e.normal_keys_for_end
    actual_1 = x.normal_keys_for_end
    assert_equal expected, actual
    assert_equal expected, actual_1
  end

  def test_lettered_keys_for_end_in_output
    e = Enigma.new("12345")
    output = "o3bx3t9"
    output_1 = "0.f3ndb395donph9f83u7oo029iueaio"
    expected = ["B", "C", "D", "A"]
    expected_1 = ["C", "D", "A", "B"]
    actual = e.lettered_keys_for_end_in_output(output)
    actual_1 = e.lettered_keys_for_end_in_output(output_1)
    assert_equal expected, actual
    assert_equal expected_1, actual_1
  end

  def test_ending_output_shift
    e = Enigma.new("12345")
    output = "0.f3ndb395donph9f83u7oo029iueaio"
    expected = [40, 9, 18, 11]
    actual = e.ending_output_shift(output)
    assert_equal expected, actual
  end

  def test_assign_date_keys
    e = Enigma.new("12345", "082918")
    output = "0.f3ndb395donph9f83u7oo029iueaio"
    actual = e.assign_date_keys_to_output(output, "082918")
    expected = ["2", "4", "4", "7"]
    assert_equal expected, actual
  end

  def test_calculate_difference
    e = Enigma.new("12345", "082918")
    output = "0.f3ndb395donph9f83u7oo029iueaio"
    actual = e.calculate_difference(output, "082918")
    expected = [-31, 12, -13, -10]
    assert_equal expected, actual
  end

  def test_rotate_to_abcd
    e = Enigma.new("12345", "082918")
    output = "0.f3ndb395donph9f83u7oo029iueaio"
    actual = e.rotate_to_abcd(output, "082918")
    expected = [-13, -10, -31, 12]
    assert_equal expected, actual
  end
end
