class Fixnum
  alias_method :old_div, :/
  alias_method :old_minus, :-

  def / other
    return nil if other == 0
    return nil if self % other != 0
    old_div other
  end

  def - other
    return nil if other > self
    old_minus other
  end

  def evaluate
    self
  end
end

class Expression < Struct.new(:op, :left, :right)
  def evaluate
    left_val, right_val = left.evaluate, right.evaluate
    return nil unless left_val && right_val
    left_val.send op, right_val
  end

  def to_s
    "(#{left}#{op}#{right})"
  end
end

class Game
  def resolve(nums)
    if nums.length == 1
      return nums[0].evaluate == 24 ? nums[0].to_s : nil
    end

    nums.permutation.each do |p|
      [:+, :-, :*, :/].each do |op|
        next_numbers = p.clone
        exp = Expression.new op, next_numbers.shift, next_numbers.shift
        result = resolve next_numbers.unshift exp
        return result if result
      end
    end

    nil
  end
end


p Game.new().resolve [2,2,23,25]
