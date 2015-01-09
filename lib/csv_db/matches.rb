class Matches
  def initialize(matches_file_path)
    @matches_file_path = matches_file_path
  end

  def setup
    FileUtils.touch @matches_file_path
  end

  def add match
    str = "#{match.team1_id}, #{match.team2_id}, #{match.team1_goals}, #{match.team2_goals}"

    File.open(@matches_file_path, "a") { |f| f.puts str }
  end
end
