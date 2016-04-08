class BankState

	@@safe_sequence = Array.new()

	def initialize(state)
		raise "Given state array is empty." if state.empty?

		# TODO: find out if we even need a "total resources" matrix - is having
		# available and allocated enough? (I think so)

		# Get important variables from the state.
		@num_resources = state[0].split(" ")[0].to_i
		@num_processes = state[0].split(" ")[1].to_i

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
		@current_need = @currently_allocated
		# For each row in current_need (each process)
		@current_need.each do |row|
			rowIndex = @current_need.index(row)
			# for each cell in the row (this process' need of resource i)
			row.each do |cell|
				cellIndex = @current_need[rowIndex].index(cell)
				cell = (@max_need[rowIndex][cellIndex] - @currently_allocated[rowIndex][cellIndex])
			end
		end

	end # end initialize

	# determines if a process is able to finish given current state
	def canFinish(process)
		res = true
		process.each do |need|
			if(need > @available_resources[process.index(need)])
				res = false
			end
		end
		if (!res) then puts("Process with needs #{process} can't finish because only #{@available_resources} are available.") end
		return res
	end

	# Finish executing a process (release its resources and remove it)
	def finishProcess(process)
		process.each do |resource|
			@available_resources[process.index(resource)] += resource
		end
		puts("Removing #{process} from the current need matrix.")
		@@safe_sequence << @current_need.index(process)
		@current_need.delete_at(@current_need.index(process))
	end

	# Determine if this state is safe
	# For each process, see if its needs can be met. If so, complete it and free
	# its resources.
	def isSafe()
		# counter prevents deadlock from spinning forever
		@counter = @num_processes
		res = true
		while (!@current_need.empty?)
			@current_need.each do |process|
				puts("Checking process #{@current_need.index(process)}.")
				if(canFinish(process))
					finishProcess(process)
					@counter = @num_processes
				else
					puts("Can't finish process #{@current_need.index(process)}. Moving on.")
					@counter -= 1
				end
				if(@counter == 0)
					res = false
					break
				end
			end
		end
		return res
	end

	def getSequence()
		return @@safe_sequence
	end
end
