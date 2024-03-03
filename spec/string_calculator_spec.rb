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

    context 'with new line (\n)' do
      it 'should be treated as comma and return sum of elements in each array element if \n is surrounded by digits' do
        expect(string_calculator.add("1", "", nil, "1\n2, 3", "", " ")).to match_array([1, 0, 6, 0, 0])
      end
   
      it 'should be treated as invalid input if it is not surrounded by digits and return sum of elements in each array element, ingoring invaild input argument' do
        expect(string_calculator.add("1", "", nil, "1\n2, 3,4", "\n, 1, \n", "", " ", "\n", "1\n3")).to match_array([1, 0, 10, 0, 0, 4])
      end
    end

    context 'with changed delimiter' do
      it 'a delimiter should be treated as comma and return sum of elements in each array element if line looks like //[delimiter]\n[numbers…]' do
        expect(string_calculator.add("1", "//!\n1!2!3", "", nil, "1\n2, 3,4", "\n, 1, \n", "//;\n1;2")).to match_array([1, 6, 0, 10, 3])
      end
    end

    context 'with negative numbers' do
      it 'should raise NegativeNumberError and display message with each negative numbers' do
        expect { string_calculator.add("1", "-2, -3 ", "", nil, "1\n2, 3,4", "-4") }.to raise_error do |error|
          expect(error).to be_a(NegativeNumberError)
          expect(error.message).to eq 'Negative numbers not allowed -2, -3 ,-4.'
        end
      end
    end

    context '#InvalidInputError' do
      it 'with alphabates should raise InvalidInputError' do
        expect { string_calculator.add("1", "a", "-2, -3 ", "", nil, "c, d", "1\n2, 3,4", "-4") }.to raise_error(InvalidInputError)
      end

      it 'with any special character should raise InvalidInputError' do
        expect { string_calculator.add("1", "-2, -3 ", "", nil, "!", "1\n2, 3,4", ".", "@") }.to raise_error(InvalidInputError)
      end
    end
  end
end

