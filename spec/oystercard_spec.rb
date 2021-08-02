require 'oystercard'

describe Oystercard do
  it 'has has an initial balance of £0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'top_up method tops up card by correct amount' do
      starting_balance = subject.balance
      expect(subject.top_up(10)).to eq starting_balance + 10
    end
  end
end
