require_relative('bank_state.rb')

class Banker
  def initialize(state)
    @state = state
    raise "Initial state is unsafe. Abort." unless state.isSafe()
  end

  def request_resources(customer_id, request)
    puts("Customer #{customer_id} requests #{request}.")

    # Below is the logic to handle incoming requests.
    available = @state.getAvailable()
    res = true
    (0..(available.length - 1)).each do |i|
      if(available[i] < request[i])
        res = false
      end
      @potential_state = @state
      @potential_state.apply_request(customer_id, request)
      if(!@potential_state.isSafe())
        res = false
      end
    end
    if res
      puts("Request granted.")
    else
      puts("Request denied.")
    end
    return res
  end

  def release_resources(customer_id, release)
    puts("Customer #{customer_id} wants to release #{release}.")
    allocated = @state.getAllocated()
    res = true
    (0..(release.length - 1)).each do |i|
      if(release[i] > allocated[customer_id][i])
        res = false
      end
    end
    if res
      puts("Request granted.")
    else
      puts("Request denied.")
    end
    return true
  end

end
