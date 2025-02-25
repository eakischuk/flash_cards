require './lib/card'
require './lib/turn'
require './lib/deck'

class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @turns = []
  end

  def current_card
    @deck.cards[@turns.count]
  end

  def take_turn(guess)
    next_turn = Turn.new(guess, current_card)

    @turns << next_turn
    next_turn
  end

  def number_correct
    correct_guesses = []

    @turns.each do |turn|
      if turn.correct? == true
        correct_guesses << turn
      end
    end

    correct_guesses.count
  end

  def number_correct_by_category(category)
    turns_by_category = []

    @turns.each do |turn|
      if turn.card.category == category
        turns_by_category << turn
      end
    end

    correct_turns_for_category = []

    turns_by_category.each do |turn|
      if turn.correct? == true
        correct_turns_for_category << turn
      end
    end
    correct_turns_for_category.count
  end

  def percent_correct
    (number_correct.to_f / @turns.count.to_f) * 100.0
  end

  def percent_correct_by_category(category)
    cards_in_category = @deck.cards_in_category(category).count
    (number_correct_by_category(category).to_f / cards_in_category.to_f) * 100.0
  end
end
