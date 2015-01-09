require "fileutils"
include FileUtils

class CsvDb
  def setup league_name, teams, fixtures
    db_dir = File.expand_path "~/.ligbot"

    mkdir db_dir unless Dir.exists? db_dir
    chdir db_dir
    if Dir.exists? league_name
      abort "League #{league_name} already exists."
    else
      mkdir league_name
    end
    chdir File.expand_path(File.join db_dir, league_name)
    touch "matches.txt"
    File.write "teams.txt", teams
    File.write "fixtures.txt", fixtures.map { |r| r.join(',')}.join("\n")
    File.write "misc.txt", "current_round : 0"
  end
end
