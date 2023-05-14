# frozen_string_literal: true

require_relative '../../lib/import_data_script'
desc 'Import log file data'
task import_data: :environment do
  puts ARGV
  file_path = ARGV[1] # Assuming the file path is passed as an argument when invoking the task
  ImportDataScript.new.run(file_path)
end
