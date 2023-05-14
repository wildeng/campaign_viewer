# frozen_string_literal: true

# lib/import_data_script.rb
class ImportDataScript
  def run(file_path)
    File.open(file_path, 'r') do |file|
      file.each_line do |line|
        next unless line.start_with?('VOTE')

        begin
          data = line.split

          next unless data.length >= 7

          campaign_name = data[2].split(':').last
          choice = data[4].split(':').last
          validity = data[3].split(':').last

          ActiveRecord::Base.transaction do
            campaign = Campaign.find_or_create_by(name: campaign_name)

            next if choice.nil? || choice.empty?

            campaign.candidates.find_or_create_by(name: choice)

            campaign.votes.create(
              choice: choice, validity: validity
            )
          end
        rescue StandardError => e
          puts 'error while trying to create campaign'
          puts line
          puts e
          next
        end
      end
    end

    Campaign.all.each(&:calculate_score)
    Campaign.all.each(&:calculate_uncounted_messages)
  end
end
