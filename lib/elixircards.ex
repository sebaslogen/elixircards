defmodule Elixircards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings represing a deck of playing cards

    ## Examples

      iex> Elixircards.create_deck
        ["Ace of Spades", "Two of Spades", "Three...
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Hearts", "Clubs", "Diamonds"]
    Enum.flat_map(suits, fn(suit) -> Enum.map(values, &("#{&1} of #{suit}")) end)
#    Alternative implementation of last line
#    Enum.flat_map(suits,
#                        fn(suit) -> Enum.map(values,
#                                                    fn(value) -> "#{value} of #{suit}" end) end)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member? deck, card
  end

  @doc """
    Divides a deck into a hand and the remaining of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

    ## Examples

      iex> Elixircards.create_deck |> Elixircards.deal(2)
        { ["Ace of Spades", "Two of Spades"], ["Three...] }
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary_data} -> :erlang.binary_to_term(binary_data)
      {:error, _} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Elixircards.create_deck
    |> Elixircards.shuffle
    |> Elixircards.deal(hand_size)
  end
end
