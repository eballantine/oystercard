class Oystercard
  attr_reader :balance, :balance_limit, :fare_min, :entry_station, :journeys

  BALANCE_DEFAULT = 0
  BALANCE_LIMIT = 90
  FARE_MIN = 1

  def initialize
    @balance = BALANCE_DEFAULT
    @balance_limit = BALANCE_LIMIT
    @fare_min = FARE_MIN
    @entry_station
    @journeys = []
  end

  def top_up(amount)
    raise "This brings your balance over the limit of £#{@balance_limit}." if @balance + amount > @balance_limit
  
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "A minimum balance of £#{@fare_min} required to travel." if @balance < @fare_min
    
    @entry_station = station
    update_journeys(station)
  end

  def touch_out(station)
    @entry_station = nil
    deduct(fare_min)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def update_journeys(station)
    @journeys << {}
    @journeys.last[:entry_station] = station
  end

end
