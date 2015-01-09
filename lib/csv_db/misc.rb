class Misc
  def initialize(misc_file_path)
    @misc_file_path = misc_file_path
  end

  def setup total_rounds
    File.write @misc_file_path, <<-EOS
current_round:1
total_rounds:#{total_rounds}
EOS
  end

  def current_round
    f = File.read @misc_file_path
    arr = f.split(/\n/).map{|x| x.split(':')}
    r = arr.assoc("current_round")[1].to_i
    t = arr.assoc("total_rounds")[1].to_i
    abort "League completed." if r > t
    r
  end

  def bump_round
    f = File.read @misc_file_path
    arr = f.split(/\n/).map{|x| x.split(':')}
    r = arr.assoc("current_round")[1]
    r = r.to_i
    r += 1
    arr.assoc("current_round")[1] = r.to_s
    File.write @misc_file_path,  arr.map{ |x| x.join(":")}.join("\n")
  end
end
