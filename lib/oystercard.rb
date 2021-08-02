class Oystercard
  attr_reader :balance, :card_limit
  attr_accessor :in_journey

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @card_limit = CARD_LIMIT
    @in_journey = false
  end

  def top_up(amount)
    raise "This brings your balance over the limit of £#{@card_limit}." if @balance + amount > @card_limit
  
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out 
    @in_journey = false
  end
end
