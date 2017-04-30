defmodule Elixircards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings represing a deck of playing cards

    ## Examples

      iex> Elixircards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Ace of Hearts", "Two of Hearts", "Three of Hearts",
       "Four of Hearts", "Five of Hearts", "Ace of Clubs", "Two of Clubs",
       "Three of Clubs", "Four of Clubs", "Five of Clubs", "Ace of Diamonds",
       "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
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

  @doc """
    Determines whether a given `deck` contains a given `card`.

    ## Examples

      iex> Elixircards.create_deck |> Elixircards.contains?("Two of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member? deck, card
  end

  @doc """
    Divides a deck into a hand and the remaining of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

    ## Examples

      iex> Elixircards.create_deck |> Elixircards.deal(2)
      {["Ace of Spades", "Two of Spades"],
       ["Three of Spades", "Four of Spades", "Five of Spades", "Ace of Hearts",
        "Two of Hearts", "Three of Hearts", "Four of Hearts", "Five of Hearts",
        "Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
        "Five of Clubs", "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds",
        "Four of Diamonds", "Five of Diamonds"]}
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

  @doc """
    Returns a hand of random cards of given `hand_size` and the rest of the cards
    in the deck as a tuple

    ## Examples

      iex> {hand, remaining_deck} = Elixircards.create_hand(5)
      iex> length(hand)
      5
      iex> length(remaining_deck)
      15
  """
  def create_hand(hand_size) do
    Elixircards.create_deck
    |> Elixircards.shuffle
    |> Elixircards.deal(hand_size)
  end
end
