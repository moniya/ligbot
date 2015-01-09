class GamePlay
  def run db
    fixtures = db.fixtures.for_current_round
    matches = fixtures.map { |f| f.play }
    matches.each { |m| db.matches.add m }
    db.bump_round
  end
end
