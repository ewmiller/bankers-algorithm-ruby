require_relative("./bank_state.rb")
require_relative("./banker.rb")
require 'thread'

File.open("./out/part2_output.txt", "w") do |file|

  # To ensure synchronization, we'll use a simple Mutex. Since customers don't need
  # to wait on shared resources themselves (the banker handles the logic) a
  # mutex is all we need.
  semaphore = Mutex.new
  customer_threads = []

  arr = IO.readlines("./resources/example2.txt")
  puts("Read file: example2.txt")
  state = BankState.new(arr)
  num_processes = state.getNumProcesses
  num_resources = state.getNumResources
  banker = Banker.new(state)

  # A customer thread. Keeps track of its id, what it needs, and what it has.
  def customer(id, max_need, allocated)
    begin
      # sleep for a random amount of seconds, from 0 to 6 (rand(7) will never generate 7)
      sleep(rand(7))
      req_or_rel = rand(2)
      if(req_or_rel == 0)
        semaphore.synchronize {
          request = []
          num_resources.times do |i|
            max_request = rand(0..(max_need[i] - allocated[i] + 1))
            request << rand(0..(max_request))
          end
          res = banker.request_resources(id, request)
          if res
            puts("This is process #{id}. My request was granted!")
            num_resources.times do |i|
              allocated[i] += request[i]
            end
          end
        }
      else
        semaphore.synchronize {
          release = []
          num_resources.times do |i|
            max_release = rand(0..(allocated[i] + 1))
            release << max_release
          end
          res2 = banker.release_resources(id, release)
          if res2
            puts("This is process #{id}. My release was granted!")
            num_resources.times do |i|
              allocated[i] -= release[i]
            end
          end
        }
      end
    end while true
  end

end # close file
