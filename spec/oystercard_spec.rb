require 'oystercard'

describe Oystercard do

  let(:station) { double('station') }
  let(:topped_up_50) { subject.top_up(50); subject }
  let(:touch_in) { subject.touch_in(station) }
  let(:on_journey) { subject.top_up(50); subject.touch_in(station) }
  let(:completed_journey) { on_journey; subject.touch_out(station) }
  let(:touch_out) { subject.touch_out(station) }

  describe '#initialize' do
    it 'has an initial balance of £0' do
      expect(subject.balance).to eq 0
    end

    it 'has no journey history' do
      expect(subject.journeys).to eq []
    end
  end

  describe '#top_up' do
    it 'increases card balance by top up amount' do
      starting_balance = subject.balance
      expect(subject.top_up(10)).to eq starting_balance + 10
    end

    describe 'top up would exceed limit' do
      it 'raises error' do
        message = "This brings your balance over the limit of £#{subject.balance_limit}."
        expect { subject.top_up(100) }.to raise_error message
      end
    end
  end

  describe '#deduct' do 
    it 'reduces balance by correct amount' do
      topped_up_50
      expect(subject.send(:deduct, 5)).to eq 45
    end
  end

  describe '#in_journey?' do
    describe 'not on a journey' do
      it 'returns false' do
        expect(subject.in_journey?).to be false
      end
    end
    describe 'on a journey' do
      it 'returns true' do
        on_journey
        expect(subject.in_journey?).to be true
      end
    end
  end

  describe '#touch_in' do
    it 'allows the user to enter barriers' do
      on_journey
      expect(subject.in_journey?).to be true
    end

    describe 'insufficient balance' do 
      it "raises error" do
        message = "A minimum balance of £#{subject.fare_min} required to travel."
        expect { touch_in }.to raise_error message
      end
    end

    describe 'after touch in' do
      it 'remembers the entry station' do
        on_journey
        expect(subject.entry_station).to eq station
      end

      it 'creates a new journey' do
        topped_up_50
        expect { touch_in }.to change{subject.journeys.length}.by(1)
      end

      it 'saves entry station into journey history' do
        on_journey
        expect(subject.journeys.last.values.first).to eq subject.entry_station
      end
    end
  end

  describe '#touch_out' do
    it 'allows the user to exit barriers' do
      completed_journey
      expect(subject.in_journey?).to be false
    end

    it 'deducts fare minimum from card balance' do
      on_journey
      expect { touch_out }.to change{subject.balance}.by(-1)    
    end

    it "forgets entry station" do
      completed_journey
      expect(subject.entry_station).to be nil
    end
  end
end
