defmodule Elixircards do
  @moduledoc """
  Documentation for Elixircards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Elixircards.hello
      :world

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Hearts", "Clubs", "Diamonds"]
    Enum.flat_map(suits, fn(suit) -> Enum.map(values, &("#{&1} of #{suit}")) end)
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
end
