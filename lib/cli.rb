module Ligbot
  class CLI

    def run argv
      options = process_args argv
      db = CsvDb.new options[:name]

      if options[:create]
        League.new.create db
      elsif options[:restart]
        League.new.restart db
      else
        # Catch file no exist as no league error
        GamePlay.new.run db
      end
    end

    def process_args argv
      argv.unshift "-h" if argv.empty?
      options = {}
      argv.options do |opts|
        opts.banner = "Usage:  ligbot [Options] OTHER_ARGS"

        opts.separator ""
        opts.separator "Options:"

        opts.on("-c", "--create", "Create league.") do |name|
          options[:create] = true
        end

        opts.on("-r", "--restart", "Restart league.") do |name|
          options[:restart] = true
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
      options[:name] = argv.shift
      options
    end

    class League
      def create db
        teams = ARGF.read
        db.setup teams
      end

    end
  end
end
