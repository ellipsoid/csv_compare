RSpec.describe 'csv_compare' do
  let(:csv_one) { './spec/fixtures/example.csv' }
  let(:output) { `./csv_compare #{csv_one} #{csv_two}` }

  context 'with matching CSVs' do
    let(:csv_two) { './spec/fixtures/good_copy.csv' }

    it 'passes' do
      expect(output).to include('No mismatches found')
    end
  end

  context 'with too many columns' do
    let(:csv_two) { './spec/fixtures/too_many_columns.csv' }

    it 'fails' do
      expect(output).to_not include('No mismatches found')
    end

    it 'reports the number of headers' do
      expect(output).to include('Number of columns does not match.')
      expect(output).to include('First CSV: 3 columns')
      expect(output).to include('Second CSV: 4 columns')
    end
  end

  context 'with too few columns' do
    let(:csv_two) { './spec/fixtures/too_few_columns.csv' }

    it 'fails' do
      expect(output).to_not include('No mismatches found')
    end

    it 'reports the number of headers' do
      expect(output).to include('Number of columns does not match.')
      expect(output).to include('First CSV: 3 columns')
      expect(output).to include('Second CSV: 2 columns')
    end
  end

  context 'with wrong headers' do
    let(:csv_two) { './spec/fixtures/wrong_headers.csv' }

    it 'fails' do
      expect(output).to_not include('No mismatches found')
    end

    it 'reports the incorrect headers' do
      expect(output).to include('Header difference in column [1]')
      expect(output).to include('First:  Header 2')
      expect(output).to include('Second:  WRONG HEADER')
    end
  end

  context 'with too few rows' do
    let(:csv_two) { './spec/fixtures/too_few_rows.csv' }

    it 'fails' do
      expect(output).to_not include('No mismatches found')
    end

    it 'reports the number of rows' do
      expect(output).to include('Number of rows does not match')
      expect(output).to include('First CSV: 4 rows')
      expect(output).to include('Second CSV: 3 rows')
    end
  end

  context 'with too many rows' do
    let(:csv_two) { './spec/fixtures/too_many_rows.csv' }

    it 'fails' do
      expect(output).to_not include('No mismatches found')
    end

    it 'reports the number of rows' do
      expect(output).to include('Number of rows does not match')
      expect(output).to include('First CSV: 4 rows')
      expect(output).to include('Second CSV: 5 rows')
    end
  end

  context 'with wrong row data' do
    let(:csv_two) { './spec/fixtures/wrong_row_data.csv' }

    it 'fails' do
      expect(output).to_not include('No mismatches found')
    end

    it 'reports first wrong value' do
      expect(output).to include('Difference on row# 1')
      expect(output).to include('Column 0 (Header 1)')
      expect(output).to include('First: [Value 1.1]')
      expect(output).to include('Second: [WRONG VALUE]')
    end

    it 'reports another wrong value' do
      expect(output).to include('Difference on row# 3')
      expect(output).to include('Column 1 ( Header 2)')
      expect(output).to include('First: [ Value 2.3]')
      expect(output).to include('Second: [ ANOTHER WRONG VALUE]')
    end
  end
end
