class BankState

	def initialize(state)
		raise "Given state is empty." if state.empty?

		# TODO: I might be adding to the Arrays wrong
		# If I instantiate them without a size, will the loops still work appropriately?
		# Maybe I have to say 'm.times do {routine to add an array to the array}'
		# TODO: make sure indices are being referenced correctly. Might have to switch m and n

		# Get important variables from the state. We will need
		# m = number of resources, n = number of processes
		@m = state[0].split(" ")[0].to_i
		@n = state[0].split(" ")[1].to_i
		puts("resources: #{@m}.")
		puts("processes: #{@n}.")

		# Get the total system resources matrix
		@total_resources = state[1].split(" ").collect{|i| i.to_i}

		# Get the max_need matrix. It will be n * m in size. Each index [0..n-1]
		# will be another array, of size m.
		@max_need = Array.new()
		for i in 2..(1 + @n) do
			@max_need << state[i].split(" ").collect{|x| x.to_i}
		end

		# Get the allocation matrix. This is the matrix of the resources each process
		# currently has.
		@currently_allocated = Array.new()
		for i in ((1 + @n)..(1 + @n + @n)) do
			@currently_allocated << state[i].split(" ").collect{|x| x.to_i}
		end

		# Get the current need matrix.
		@current_need = Array.new()
		for n_index in 0..(@m - 1) do
			@current_need << Array.new(@n)
			for m_index in 0..(@n - 1)
				# TODO: something is nil here
				@current_need[n_index][m_index] = @max_need[n_index][m_index] - @currently_allocated[n_index][m_index]
			end
		end

		# Get the available resources matrix
		@available_resources = Array.new()
		for n_index in 0..(@m - 1) do
			@available_resources << Array.new(@n)
			for m_index in 0..(@n - 1)
				@available_resources[n_index][m_index] = @total_resources[n_index][m_index] - @currently_allocated[n_index][m_index]
			end
		end
	end

	# determine if this state is safe
	def isSafe()
		return true
	end
end
