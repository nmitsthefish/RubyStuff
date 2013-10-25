require 'test/unit'
require './consecutive'

class ConsecutiveTest < Test::Unit::TestCase

  def test_max_consecutive_characters_should_return_an_array
    c = Consecutive.new "aaddddffffaa"
    assert_kind_of Array, c.max_consecutive_characters
  end
  
  def test_cat_dog___
    c = Consecutive.new "cat dog ___"
    assert_equal %w(_), c.max_consecutive_characters
  end

  def test_aabbaabbbaa
    c = Consecutive.new "aabbaabbbaa"
    assert_equal %w(b), c.max_consecutive_characters
  end

  def test_aabaa
    c = Consecutive.new "aabaa"
    assert_equal %w(a), c.max_consecutive_characters
  end  	

  def test_aaddddffffaa
    c = Consecutive.new "aaddddffffaa"
    assert_equal %w(d f), c.max_consecutive_characters
  end
  
  def test_sort_order
    c = Consecutive.new "bbaa"
    assert_equal %w(a b), c.max_consecutive_characters
  end
  
  def test_not_highest_letter_most_common
    c = Consecutive.new "aaaaaaaaaaaaaaaaaaaaaaaaaaaazbb"
    assert_equal %w(a), c.max_consecutive_characters
  end

  def test_multiple_character_instances
    c = Consecutive.new "aaabba"
    assert_equal %w(a), c.max_consecutive_characters
  end
end

class CharCounterTest < Test::Unit::TestCase
	def test_count_chars_should_return_a_hash
    c = CharCounter.new "aaddddffffaa"
    assert_kind_of Hash, c.count_chars
  end

	def test_number_of_chars_in_hash
		c = CharCounter.new "123456789"
		assert_equal 9, c.count_chars.length
	end
	
	def test_count_chars_correctly
		c = CharCounter.new "tesssst"
		assert_equal 4, c.count_chars['s']
	end

	def test_proper_input_is_a_string
		assert_raise(ArgumentError) do
			c = CharCounter.new(1234)
		end
	end
end

class HashAnalyzerTest < Test::Unit::TestCase
	
	def test_determine_most_consecutive_should_return_an_array
    test_hash = { "a" => 1, "b" => 2, "c" => 1 }
		c = HashAnalyzer.new test_hash
    assert_kind_of Array, c.determine_most_consecutive
  end
	
	def test_proper_input_is_hash
		assert_raise(ArgumentError) do
			c = HashAnalyzer.new(1234)
		end
	end
end


