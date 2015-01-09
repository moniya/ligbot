class Teams
  def initialize(teams_file_path)
    @teams_file_path = teams_file_path
  end

  def setup teams
    File.write @teams_file_path, teams
  end
end

