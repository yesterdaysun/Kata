class FARule < Struct.new(:state, :character, :next_state)
  def applied_to?(state, character)
    self.state == state && self.character == character
  end
end

class DFARuleBook < Struct.new(:rules)
  def next_state(state, character)
    rule_for(state, character).next_state
  end

  def rule_for(state, character)
    rules.detect { |rule| rule.applied_to?(state, character) }
  end
end

class DFA < Struct.new(:current_state, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(string)
    string.each_char do |character|
      read_character(character)
    end
  end
end

tennis_rules = [
  ['0 0','1', '15 0'],
  ['0 0','2', '0 15'],

  ['15 0','1', '30 0'],
  ['15 0','2', '15 15'],
  ['0 15','1', '15 15'],
  ['0 15','2', '0 30'],

  ['30 0','1', '40 0'],
  ['30 0','2', '30 15'],
  ['15 15','1', '30 15'],
  ['15 15','2', '15 30'],
  ['0 30', '1', '15 30'],
  ['0 30', '2', '0 40'],

  ['40 0','1', 'Player 1 win!'],
  ['40 0','2', '40 15'],
  ['30 15','1', '40 15'],
  ['30 15','2', '30 30'],
  ['15 30','1', '30 30'],
  ['15 30','2', '15 40'],
  ['0 40','1', '15 40'],
  ['0 40','2', 'Player 2 win!'],

  ['40 15','1', 'Player 1 win!'],
  ['40 15','2', '40 30'],
  ['30 30','1', '40 30'],
  ['30 30','2', '30 40'],
  ['15 40','1', '30 40'],
  ['15 40','2', 'Player 2 win!'],

  ['40 30','1', 'Player 1 win!'],
  ['40 30','2', 'deuce'],
  ['30 40','1', 'deuce'],
  ['30 40','2', 'Player 2 win!'],

  ['deuce','1', 'Player 1 advantage'],
  ['deuce','2', 'Player 2 advantage'],

  ['Player 1 advantage', '1', 'Player 1 win!'],
  ['Player 1 advantage', '2', 'deuce'],
  ['Player 2 advantage', '1', 'deuce'],
  ['Player 2 advantage', '2', 'Player 2 win!']
]

@@tennis_rulebook = DFARuleBook.new(tennis_rules.map {|rule| FARule.new(*rule)})

# Test
require "test/unit"
class TestSimpleNumber < Test::Unit::TestCase
  [
    ['1', '15 0'],
    ['2', '0 15'],
    ['1111', 'Player 1 win!'],
    ['121222', 'Player 2 win!']
  ].each do |plays, expected_state|
    test "tennis from start, and after #{plays}, result should be #{expected_state}" do
      dfa = DFA.new('0 0', ['Player 1 win!', 'Player 2 win!'], @@tennis_rulebook)
      assert_equal expected_state, dfa.tap{|dfa| dfa.read_string(plays)}.current_state
    end
  end

  [
    ['40 15', '1', 'Player 1 win!'],
    ['30 30', '2', '30 40'],
    ['30 30', '12', 'deuce'],
    ['deuce', '12', 'deuce'],
    ['deuce', '122', 'Player 2 advantage'],
    ['deuce', '1222', 'Player 2 win!']
  ].each do |start_state, plays, expected_state|
    test "tennis from #{start_state}, and after #{plays}, result should be #{expected_state}" do
      dfa = DFA.new(start_state, ['Player 1 win!', 'Player 2 win!'], @@tennis_rulebook)
      assert_equal expected_state, dfa.tap{|dfa| dfa.read_string(plays)}.current_state
    end
  end
end
