class Oystercard
  attr_reader :balance, :card_limit

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @card_limit = CARD_LIMIT
  end

  def top_up(amount)
    raise "This brings your balance over the limit of £#{@card_limit}." if @balance + amount > @card_limit

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
