class Oystercard
  attr_reader :balance, :card_limit, :fare_min, :journeys, :entry_station

  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90
  FARE_MIN = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @card_limit = CARD_LIMIT
    @fare_min = FARE_MIN
    @entry_station
    @journeys = []
  end

  def top_up(amount)
    raise "This brings your balance over the limit of £#{@card_limit}." if @balance + amount > @card_limit
  
    @balance += amount
  end

  def in_journey?
    @entry_station ? true : false
  end

  def touch_in(station)
    raise "You need a minimum balance of #{@fare_min} in order to touch in." if @balance < @fare_min
    @entry_station = station
    @journeys << {}
    @journeys.last[:entry_station] = ""
    # unable to get the last journey key to match the station double value
  end

  def touch_out(station)
    @entry_station = nil
    deduct(fare_min)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
