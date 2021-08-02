require 'oystercard'

describe Oystercard do
  it 'has has an initial balance of £0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up card by correct amount' do
      starting_balance = subject.balance
      expect(subject.top_up(10)).to eq starting_balance + 10
    end

    it 'if it would bring oyster balance above limit, raise error' do
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
end
