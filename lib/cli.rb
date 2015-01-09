module Ligbot
  class CLI
    class Creator
      def run db
        teams = ARGF.read
        fixtures = FixtureGenerator.run teams.split("\n")
        db.setup teams, fixtures
      end

    end
    def run argv
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
      db = CsvDb.new name

      if options[:create]
        Creator.new.run db
      else
        # Catch file no exist as no league error
        GamePlay.new.run db
      end
    end
  end
end
