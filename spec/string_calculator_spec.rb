# To run test 'rspec ./spec/string_calculator_spec.rb'
require_relative '../string_calculator'

describe StringCalculator do
  context '#add' do
    let(:string_calculator) { StringCalculator.new }

    context '#NilInputError' do
      it 'should raise NilInputError for nil' do
        expect { 
          string_calculator.add(nil) 
        }.to raise_error(NilInputError)
      end
    end
  end
end

