RSpec.describe Xlsx2Csv do
  describe '.convert' do
    it 'should convert XLSX file to CSV' do
      expected_csv = File.read(File.join(File.dirname(__FILE__), 'file/test.csv'))
      options = {
        file: File.join(File.dirname(__FILE__), 'file/test.xlsx'),
        out: File.join(Dir.tmpdir, 'out.csv')
      }

      begin
        described_class.convert(options)

        expect(File.read(options[:out])).to eq expected_csv
      ensure
        File.unlink(options[:out]) if File.exist?(options[:out])
      end
    end
  end
end
