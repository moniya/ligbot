Fixture = Struct.new(:team1, :team2) do
  def play
    Match.new team1, team2, gen_goals, gen_goals
  end

  def gen_goals
    boom = rand 100
    case boom
    when 0; 5
    when 1; 4
    when 2...9; 3
    when 9...32; 2
    when 32...65; 1
    when 65...100; 0
    end
  end
end
