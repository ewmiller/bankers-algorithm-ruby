class BankState

	def initialize(state)
		raise "Given state is empty." if state.empty?

		# TODO: I might be adding to the Arrays wrong
		# If I instantiate them without a size, will the loops still work appropriately?
		# Maybe I have to say 'm.times do {routine to add an array to the array}'
		# TODO: make sure indices are being referenced correctly. Might have to switch m and n.

		# Get important variables from the state. We will need
		# m = number of resources, n = number of processes
		@num_resources = state[0].split(" ")[0].to_i
		@num_processes = state[0].split(" ")[1].to_i
		puts("resources: #{@num_resources}.")
		puts("processes: #{@num_processes}.")

		# Get the total system resources matrix
		@total_resources = state[1].split(" ").collect{|i| i.to_i}
		puts(@total_resources)

		# Get the max_need matrix. It will be n * m in size. Each index [0..n-1]
		# will be another array, of size m.
		@max_need = Array.new()
		for i in 2..(1 + @num_processes) do
			@max_need << state[i].split(" ").collect{|x| x.to_i}
		end
		puts(@max_need)

		# Get the allocation matrix. This is the matrix of the resources each process
		# currently has.
		@currently_allocated = Array.new()
		for i in ((1 + @num_processes)..(1 + @num_processes + @num_processes)) do
			@currently_allocated << state[i].split(" ").collect{|x| x.to_i}
		end
		puts(@currently_allocated)

		# Get the current need matrix.
		@current_need = @max_need
		@current_need.each do |row|
			rowIndex = @current_need.index(row)
			puts("index of row: #{rowIndex}")
			row.each do |cell|
				cellIndex = @current_need[rowIndex].index(cell)
				puts("index of cell: #{cellIndex}")
				cell = cell - @currently_allocated[rowIndex][cellIndex]
			end
		end

		# Get the available resources matrix

	end

	# determine if this state is safe
	def isSafe()
		return true
	end
end
