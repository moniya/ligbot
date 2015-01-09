class Fixtures
  def initialize(db, fixtures_file_path)
    @db = db
    @fixtures_file_path = fixtures_file_path
  end

  def setup fixtures_arr
    @fixtures_arr = fixtures_arr
    File.write @fixtures_file_path, @fixtures_arr.map { |r| r.join(',')}.join("\n")
  end

  def all
    f = File.read @fixtures_file_path
    f.split(/\n/).map { |r| r.split(/,/).map { |x| Fixture.new x.split(':')[0], x.split(':')[1] }}
  end

  def for_round round_id
    all[round_id-1]
  end

  def for_current_round
    for_round current_round
  end

  def current_round
     @db.misc.current_round
  end
end
