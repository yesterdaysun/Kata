require 'rspec'
require './game'

describe "24 points game" do
  def should_success(nums, expected)
    result = Game.new().resolve nums
    expect(result).to eq expected
  end

  def should_fail(nums)
    result = Game.new().resolve nums
    expect(result).to eq nil
  end

  context "with 1 number" do
    it "should return 24 if equals" do
      should_success [24], "24"
    end

    it "should return nil if not equals" do
      should_fail [23]
    end
  end

  context "with 2 numbers" do
    it "should success if a+b=24" do
      should_success [1, 23], "(1+23)"
    end

    it "should fail if a+b!=10" do
      should_fail [1,1]
    end

    it "should success if a-b=24" do
      should_success [26, 2], "(26-2)"
    end

    it "should success if a*b=24" do
      should_success [2, 12], "(2*12)"
    end

    it "should success if a/b=24" do
      should_success [48, 2], "(48/2)"
    end

    it "should fail if not exact division" do
      should_fail [49, 2]
    end

    it "should fail if divided by 0" do
      should_fail [49, 0]
    end

    it "shoud success if b-a=24" do
      should_success [2,26], "(26-2)"
    end
  end

  context "with 3 number" do
    it "should success if a+b+c=24" do
      should_success [2,2,20], "((2+2)+20)"
    end

    it "should success if a+(b*c)=24" do
      should_success [4,2,10], "((2*10)+4)"
    end
  end

  context "with 4 numbers" do
    it "should success for 5,5,5,5" do
      should_success [5,5,5,5], "((5*5)-(5/5))"
    end

    it "should success for 2,3,5,7, make sure middle number is not negtive" do
      should_success [2,4,5,7], "((5+7)*(4-2))"
    end
  end
end

describe "expression for display" do
  it "should return '(a+b)' if a+b" do
    exp = Expression.new :+, 1, 23
    expect(exp.to_s).to eq "(1+23)"
  end

  it "should return 10 if a+b=10" do
    exp = Expression.new :+, 3, 7
    expect(exp.evaluate).to eq 10
  end
end

RSpec::Core::Runner.run(['spec'])
