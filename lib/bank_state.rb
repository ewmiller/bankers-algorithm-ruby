class BankState

	@@safe_sequence = Array.new()

	def initialize(state)
		raise "Given state is empty." if state.empty?

		# TODO: make sure indices are being referenced correctly.

		# Get important variables from the state. We will need
		# m = number of resources, n = number of processes
		@num_resources = state[0].split(" ")[0].to_i
		@num_processes = state[0].split(" ")[1].to_i
		puts("resources: #{@num_resources}.")
		puts("processes: #{@num_processes}.")

		# Get the total system resources matrix
		@total_resources = state[1].split(" ").collect{|i| i.to_i}
		puts("Total resources array: #{@total_resources}")

		# Get the max_need matrix. It will be n * m in size. Each index [0..n-1]
		# will be another array, of size m.
		@max_need = Array.new()
		for i in 2..(1 + @num_processes) do
			@max_need << state[i].split(" ").collect{|x| x.to_i}
		end
		puts("Max need array: #{@max_need}")

		# Get the allocation matrix. This is the matrix of the resources each process
		# currently has.
		@currently_allocated = Array.new()
		for i in ((2 + @num_processes)..(1 + @num_processes + @num_processes)) do
			@currently_allocated << state[i].split(" ").collect{|x| x.to_i}
		end
		puts("Currently allocated array: #{@currently_allocated}")

		# Get the current need matrix.
		@current_need = @max_need
		@current_need.each do |row|
			rowIndex = @current_need.index(row)
			row.each do |cell|
				cellIndex = @current_need[rowIndex].index(cell)
				cell = cell - @currently_allocated[rowIndex][cellIndex]
			end
		end

		# Get the available resources matrix
		# TODO: values are ending up negative somehow... probably hitting the wrong indices
		@available_resources = @total_resources
			@currently_allocated.each do |row|
				rowIndex = @currently_allocated.index(row)
				puts("Currently Allocated row: #{rowIndex}")
				@currently_allocated[rowIndex].each do |cell|
					cellIndex = @currently_allocated[rowIndex].index(cell)
					puts("Currently Allocated cell: #{cellIndex}")
					@available_resources[cellIndex] -= cell
					puts("Available resources [#{cellIndex}] = #{@available_resources[cellIndex]}.")
					puts("#{@available_resources[cellIndex]} - #{cell}")
				end
			end

		puts("Available resources array: #{@available_resources}")

	end

	# determine if this state is safe
	def isSafe()
		return true
	end

	def getSequence()
		return @@safe_sequence
	end
end
