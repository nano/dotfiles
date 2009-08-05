require "irb/completion"

IRB.conf[:PROMPT_MODE] = :SIMPLE

#
# Benchmark
#
def time(times=1)
  require "benchmark"
  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end
