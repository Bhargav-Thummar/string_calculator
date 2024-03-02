# To run test 'rspec ./spec/string_calculator_spec.rb'
require_relative '../string_calculator'

describe StringCalculator do
  context '#add' do
    let(:string_calculator) { StringCalculator.new }

    context '#NilInputError' do
      it 'should raise NilInputError for nil' do
        expect { string_calculator.add(nil) }.to raise_error(NilInputError)
      end
    end

    context 'empty string' do
      it 'should include 0 in output' do
        expect(string_calculator.add("")).to include(0)
      end

      it 'should include 0 in output' do
        expect(string_calculator.add("", nil, "")).to match_array([0, 0])
      end
    end

    context 'with nil, empty strings, numbers' do
      it 'should return sum of elements in each array element' do
        expect(string_calculator.add("1", "", nil, "1, 2, 3", "", " ")).to match_array([1, 0, 6, 0, 0])
      end
    end
  end
end

