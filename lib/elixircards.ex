defmodule Elixircards do
  @moduledoc """
  Documentation for Elixircards.
  """

  @doc """
  Create deck.

  ## Examples

      iex> Elixircards.create_deck
        ["Ace of Spades", "Two of Spades", "Three...
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Hearts", "Clubs", "Diamonds"]
    Enum.flat_map(suits, fn(suit) -> Enum.map(values, &("#{&1} of #{suit}")) end)
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

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    {status, data} = File.read(filename)
    case status do
      :ok -> :erlang.binary_to_term(data)
      :error -> "That file does not exist"
    end
  end
end
