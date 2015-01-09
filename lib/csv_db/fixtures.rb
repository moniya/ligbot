class Fixtures
  def initialize(db, fixtures_file_path)
    @db = db
    @fixtures_file_path = fixtures_file_path
  end

  def setup teams
    fixtures_arr = FixtureGenerator.run teams.split("\n")
    File.write @fixtures_file_path, fixtures_arr.map { |r| r.join(',')}.join("\n")
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

  module FixtureGenerator
    module_function

    def run(teams)
      [].tap{ |result|
        teams = Array teams
        no_of_iter = teams.length - 1

        no_of_iter.times do
          result << cohere(teams)
          rotate_tail(teams)
        end
      }
    end

    def rotate_tail(arr)
      first = arr.shift
      arr.rotate!(-1).unshift first
    end

    def cohere(arr)
      arr_dup = arr.dup
      [].tap { |res|
        res << [arr_dup.shift, arr_dup.pop].join(':') while arr_dup.any?
      }
    end
  end

end
