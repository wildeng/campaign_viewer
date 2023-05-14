# frozen_string_literal: true


# spec/lib/import_data_script_spec.rb
require 'rails_helper'
require Rails.root.join('lib', 'import_data_script')

RSpec.describe 'ImportDataScript' do
  describe '#run' do
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'log_file.txt') }
    let(:invalid_file_path) { Rails.root.join('spec', 'fixtures', 'log_file_invalid_data.txt') }

    it 'imports valid log file data' do
      ImportDataScript.new.run(file_path)

      expect(Campaign.first.name).to eq('ssss_uk_01B')
      expect(Campaign.first.candidates.length).to eq(3)
      expect(Vote.count).to eq(4)
    end

    it 'skips invalid data' do
      ImportDataScript.new.run(invalid_file_path)
      puts Campaign.first.candidates.pluck(:name)

      expect(Campaign.first.name).to eq('ssss_uk_01B')
      expect(Campaign.first.candidates.length).to eq(1)
      expect(Campaign.first.candidates.first.uncounted_messages).to eq(2)
      expect(Vote.count).to eq(3)
    end
  end
end
