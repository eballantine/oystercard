require 'oystercard'

describe Oystercard do
  it 'has an initial balance of £0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'increases card balance by correct amount' do
      starting_balance = subject.balance
      expect(subject.top_up(10)).to eq starting_balance + 10
    end

    it 'if it would bring oyster balance above limit, raises error' do
      message = "This brings your balance over the limit of £#{subject.card_limit}."
      expect { subject.top_up(100) }.to raise_error message
    end
  end

  describe '#deduct' do 
    it 'reduces balance by correct amount' do
      subject.top_up(50)
      expect(subject.deduct(5)).to eq 45
    end
  end

  describe '#in_journey?' do
    it 'returns false when a card is not on a journey' do
      expect(subject.in_journey?).to be false
    end

    it 'returns true when a card is on a journey' do
      subject.touch_in
      expect(subject.in_journey?).to be true
    end
  end

  describe '#touch_in' do
    it 'allows the user to enter barriers' do
      subject.touch_in
      expect(subject.in_journey?).to be true
    end  
  end

  describe '#touch_out' do
    it 'allows the user to exit barriers' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to be false
    end
  end
end
