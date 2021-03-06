class BankState

	def initialize(state)
		raise "Given state array is empty." if state.empty?

		# Get important variables from the state.
		@num_resources = state[0].split(" ")[0].to_i
		@num_processes = state[0].split(" ")[1].to_i

		# An array containing a safe sequence of processes
		@safe_sequence = Array.new(@num_processes, 0)

		# Get the currently available resource matrix
		@available_resources = state[1].split(" ").collect{|i| i.to_i}

		# Get the max_need matrix.
		@max_need = Array.new()
		for i in 2..(1 + @num_processes) do
			@max_need << state[i].split(" ").collect{|x| x.to_i}
		end

		# Get the allocation matrix.
		@currently_allocated = Array.new()
		for i in ((2 + @num_processes)..(1 + @num_processes + @num_processes)) do
			@currently_allocated << state[i].split(" ").collect{|x| x.to_i}
		end

		# Initialize the current need matrix.
		@current_need = @currently_allocated.map { |e| e.dup  }
		(0..(@num_processes - 1)).each do |i|
			(0..(@num_resources - 1)).each do |j|
				@current_need[i][j] = @max_need[i][j] - @currently_allocated[i][j]
			end
		end

		# An array to keep track of active processes
		@active = Array.new(@num_processes, true)

	end # end initialize

	# determines if a process is able to finish given current state
	def canFinish(process)
		res = true
		process.each do |need|
			current_need = @current_need[@current_need.index(process)][process.index(need)]
			if((current_need) > @available_resources[process.index(need)])
				res = false
			end
		end
		return res
	end

	# Finish executing a process (release its resources and remove it)
	def finishProcess(process, processId)
		process.each do |resource|
			@available_resources[process.index(resource)] += resource
		end
		@safe_sequence[processId] = processId + 1
		@active[processId] = false
	end

	def isActive(process)
		return @active[@current_need.index(process)]
	end

	# Determine if this state is safe
	# For each process, see if its needs can be met. If so, complete it and free
	# its resources.
	def isSafe()
		res = true
		# count prevents deadlock from looping forever
		count = 0
		while(true)
			counter = 0
			@current_need.each do |process|
				if(isActive(process))
					if(canFinish(process))
						processId = @current_need.index(process)
						finishProcess(@currently_allocated[processId], processId)
						counter = counter - 1
						res = true
					else
						counter = counter + 1
						res = false
					end
				else
					counter = counter + 1
				end
			end
			if(counter = @num_processes)
				break
			end
		end
		return res
	end

	# Fulfills a process request in real-time. Should not be called while
	# checking if the state is safe.
	# processId is the index of the process
	def apply_request(processId, request)
		(0..(request.length - 1)).each do |i|
			@currently_allocated[processId][i] += request[i]
			@available_resources[i] -= request[i]
		end
	end

	def getSequence()
		return @safe_sequence
	end

	def getNumResources()
		return @num_resources
	end

	def getNumProcesses()
		return @num_processes
	end

	def getMaxNeed()
		return @max_need
	end

	def getAllocated()
		return @currently_allocated
	end

	def getAvailable()
		return @available_resources
	end
end
