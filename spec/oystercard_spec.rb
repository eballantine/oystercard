require 'oystercard'

describe Oystercard do

  let(:station) { double('station') }
  let(:top_up_50) { subject.top_up(50) }
  let(:touch_in) { subject.touch_in(station) }
  let(:touch_out) { subject.touch_out }

  describe '#initialize' do
    it 'has an initial balance of £0' do
      expect(subject.balance).to eq 0
    end
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
      top_up_50
      expect(subject.send(:deduct, 5)).to eq 45
    end
  end

  describe '#in_journey?' do
    it 'returns false when a card is not on a journey' do
      expect(subject.in_journey?).to be false
    end

    it 'returns true when a card is on a journey' do
      top_up_50
      touch_in
      expect(subject.in_journey?).to be true
    end
  end

  describe '#touch_in' do
    it 'allows the user to enter barriers' do
      top_up_50
      touch_in
      expect(subject.in_journey?).to be true
    end

    it "should only let customer touch_in if they have the required." do
      message = "You need a minimum balance of #{subject.fare_min} in order to touch in."
      expect { touch_in }.to raise_error message
    end

    it 'remembers the entry station after touch in' do
      top_up_50
      touch_in
      expect(subject.journeys).to eq [[station]]
    end
  end

  describe '#touch_out' do
    it 'allows the user to exit barriers' do
      top_up_50
      touch_in
      touch_out
      expect(subject.in_journey?).to be false
    end

    it 'deducts fare minimum from card balance' do
      top_up_50
      touch_in
      expect { touch_out }.to change{subject.balance}.by(-1)    
    end
  end
end
