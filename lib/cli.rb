module Ligbot
  class CLI
    class Creator
      def run name, db
        name = name
        teams = ARGF.read
        fixtures = FixtureGenerator.run teams.split("\n")
        db.setup name, teams, fixtures
      end

    end
    def main argv
      argv.unshift "-h" if argv.empty?
      options = {}
      argv.options do |opts|
        opts.banner = "Usage:  ligbot [Options] OTHER_ARGS"

        opts.separator ""
        opts.separator "Options:"

        opts.on("-c", "--create", "Create league.") do |name|
          options[:create] = name
        end

        opts.on( "-h", "--help",
                 "Show this message." ) do
          puts opts
          exit
        end

        begin
          opts.parse!
        rescue
          puts opts
          exit
        end
      end
      name = argv.shift
      if options[:create]
        db = CsvDb.new

        Creator.new.run name, db
      else
        GamePlay.new.run name, db
      end
    end
  end
end
