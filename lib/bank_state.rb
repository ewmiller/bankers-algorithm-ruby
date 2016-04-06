class BankState

	def initialize(state)
		raise "Given state is empty." if state.empty?

		# get important variables from the state
		@num_resources = state[0].split(" ")[0].to_i
		@num_processes = state[0].split(" ")[1].to_i
		puts("resources: #{@num_resources}.")
		puts("processes: #{@num_processes}.")

		@total = state[1].split(" ")
		@total.each do |i|
			i = i.to_i
		end

		@max_need = Array.new(@num_processes)
		

	end

	# determine if this state is safe
	def isSafe()
		return true
	end
end
