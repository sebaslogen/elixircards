defmodule ElixircardsTest do
  use ExUnit.Case
  doctest Elixircards

  test "create_deck makes 20 cards" do
    assert 20 == length(Elixircards.create_deck())
  end

  test "shuffle randomizes the order of cards in a deck" do
    deck = Elixircards.create_deck()
    assert deck != Elixircards.shuffle(deck)
  end
end
