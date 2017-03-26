require 'takeaway'

describe Takeaway do

  subject(:takeaway) { described_class.new }
  let(:dish) { double(:dish) }
  let(:amount) { double(:amount) }
  let(:price) { double(:price) }

  describe '#select_dish' do
    before { $stdin = StringIO.new("Nandos")}

    it 'sends the dish and amount to the order' do
      allow(takeaway).to receive(:get_price) {price}
      expect(takeaway.order).to receive(:add).with(dish, price, amount)
      takeaway.select_dish(dish, amount)
    end
  end

  describe 'checkout' do

    context 'when the order is not right' do
      it 'raises an error' do
        $stdin = StringIO.new("Nandos")
        takeaway
        $stdin = StringIO.new("N")
        expect{takeaway.checkout}.to raise_error "Apologies for getting your order wrong."
      end
    end
  end
end
