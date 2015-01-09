require "fileutils"
require "lib/csv_db/fixtures"
require "lib/csv_db/matches"
require "lib/csv_db/misc"
require "lib/csv_db/teams"

include FileUtils

class CsvDb
  attr_reader :matches, :teams, :fixtures, :misc

  def initialize league_name
    @league_name = league_name
    @db_dir      = File.expand_path "~/.ligbot"
    @league_dir  = File.join @db_dir, @league_name

    @matches  = Matches.new File.join(@league_dir, "matches.txt")
    @teams    = Teams.new File.join(@league_dir, "teams.txt")
    @fixtures = Fixtures.new self, File.join(@league_dir, "fixtures.txt")
    @misc     = Misc.new File.join(@league_dir, "misc.txt")

  end

  def setup teams
    mkdir @db_dir unless Dir.exists? @db_dir
    chdir @db_dir
    if Dir.exists? @league_name
      abort "League @league_name already exists."
    else
      mkdir @league_name
    end
    @matches.setup
    @teams.setup teams
    @fixtures.setup teams
    @misc.setup teams
  end

  def restart_league
    @matches.delete_all
    @misc.restart_rounds
  end

  def bump_round
    @misc.bump_round
  end
end

