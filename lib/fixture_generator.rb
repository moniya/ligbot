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
