require 'test/unit'
require './nonary_game'

class NonaryGameTest < Test::Unit::TestCase

  SOLUTIONS = %w( 12357 12456 135 1458 15678 2358 2457 3456 34578 567 )
  
  def setup
    nonary_game = NonaryGame.new
    @solutions = nonary_game.valid_groups
  end
  
  def test_returns_an_array_of_solutions
    assert_kind_of Array, @solutions
  end
  
  def test_each_solution_is_an_array
    @solutions.each do |solution|
      assert_kind_of Array, solution
    end
  end
  
  def test_solutions_to_nonary_game
    sorted_solutions = @solutions.map { |sol| sol.sort.join }.sort

    assert_equal SOLUTIONS, sorted_solutions
  end

end

class DigitalRootTest < Test::Unit::TestCase
  def test_input_is_non_numerical_string
    assert_raise(ArgumentError) { dr = DigitalRoot.new("test") }
  end
	
  def test_input_is_non_numerical_array
    assert_raise(ArgumentError) { dr = DigitalRoot.new(["t","es","t","2"]) }
  end
	 
  def test_input_is_invalid_type
    assert_raise(ArgumentError) { dr = DigitalRoot.new({'b'=>2, 'a'=>1}) }
  end
	
  def test_digital_root_is_correct
    dr = DigitalRoot.new("2437")
    assert_equal true, dr.has_value?(7)
  end
	
  def test_digital_root_is_correct_from_array
    dr = DigitalRoot.new(["2","43","7"])
    assert_equal true, dr.has_value?(7)
  end
end